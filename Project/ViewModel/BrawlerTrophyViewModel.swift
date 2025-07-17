//
//  BrawlerTrophyViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import Foundation
import RxSwift
import Alamofire
import Alamofire


protocol BrawlerTrophyDataSource {
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]>
}

class MockBrawlerTrophyDataSourceImpl: BrawlerTrophyDataSource {
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]> {
        return Observable.just([
            TrophyGraphData(date: "2/10", trophy: 850),
            TrophyGraphData(date: "2/11", trophy: 870),
            TrophyGraphData(date: "2/12", trophy: 900),
            TrophyGraphData(date: "2/13", trophy: 920),
            TrophyGraphData(date: "2/14", trophy: 950),
            TrophyGraphData(date: "2/15", trophy: 970),
            TrophyGraphData(date: "2/16", trophy: 990),
            TrophyGraphData(date: "2/17", trophy: 1990)
        ])
    }
}

class BrawlerTrophyRemoteDataSourceImpl: BrawlerTrophyDataSource {
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]> {
        return Observable.create { observer in
            guard let playerTag = UserDefaults.standard.string(forKey: "playerTag") else {
                observer.onError(NSError(domain: "BrawlerTrophyError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Player tag not found in UserDefaults"]))
                return Disposables.create()
            }

            let cleanedPlayerTag = playerTag.hasPrefix("#") ? String(playerTag.dropFirst()) : playerTag
            let url = Constants.fetchTrophyGraphURL
            let parameters: [String: Any] = ["playertag": cleanedPlayerTag, "brawlerName": brawlerName]

            AF.request(url, parameters: parameters).responseDecodable(of: [TrophyGraphData].self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}

protocol BrawlerTrophyRepository {
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]>
}

class BrawlerTrophyRepositoryImpl: BrawlerTrophyRepository {
    private let dataSource: BrawlerTrophyDataSource
    
    init(dataSource: BrawlerTrophyDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]> {
        return dataSource.fetchBrawlerTrophyData(brawlerName: brawlerName)
    }
}

protocol BrawlerTrophyUseCase {
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]>
}

class BrawlerTrophyUseCaseImpl: BrawlerTrophyUseCase {
    
    let repository: BrawlerTrophyRepository
    
    init(repository: BrawlerTrophyRepository) {
        self.repository = repository
    }
    
    func fetchBrawlerTrophyData(brawlerName: String) -> Observable<[TrophyGraphData]> {
        return repository.fetchBrawlerTrophyData(brawlerName: brawlerName)
        .map { trophyData in
            // 날짜 오름차순으로 정렬 (시간 순서대로)
            return trophyData.sorted { first, second in
                let firstDate = self.parseDate(from: first.date)
                let secondDate = self.parseDate(from: second.date)
                return firstDate < secondDate // 오름차순 정렬
            }
        }
    }
    
    // 날짜 문자열을 Date 객체로 변환하는 메서드
       private func parseDate(from dateString: String) -> Date {
           let formatter = DateFormatter()
           formatter.dateFormat = "M/d" // "2/10" 형식에 맞춤
           formatter.locale = Locale(identifier: "en_US")
           
           // 연도가 없으므로 현재 연도로 가정
           let currentYear = Calendar.current.component(.year, from: Date())
           let fullDateString = "\(currentYear)/\(dateString)"
           
           formatter.dateFormat = "yyyy/M/d"
           return formatter.date(from: fullDateString) ?? Date.distantPast
       }
    
}



class BrawlerTrophyViewModel: ObservableObject {
    @Published var trophyData: [TrophyGraphData] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let useCase: BrawlerTrophyUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: BrawlerTrophyUseCase) {
        self.useCase = useCase
    }
    
    func loadTrophyData(brawlerName: String) {
        isLoading = true
        errorMessage = nil
        
        useCase.fetchBrawlerTrophyData(brawlerName: brawlerName)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] data in
                    self?.trophyData = data
                    self?.isLoading = false
                },
                onError: { [weak self] error in
                    self?.errorMessage = error.localizedDescription
                    self?.isLoading = false
                }
            )
            .disposed(by: disposeBag)
    }
    
}
