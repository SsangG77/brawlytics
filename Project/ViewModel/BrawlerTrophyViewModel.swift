//
//  BrawlerTrophyViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 6/24/25.
//

import Foundation
import RxSwift


protocol BrawlerTrophyDataSource {
    func fetchBrawlerTrophyData() -> Observable<[TrophyGraphData]>
}

class MockBrawlerTrophyDataSourceImpl: BrawlerTrophyDataSource {
    func fetchBrawlerTrophyData() -> Observable<[TrophyGraphData]> {
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

protocol BrawlerTrophyRepository {
    func fetchBrawlerTrophyData() -> Observable<[TrophyGraphData]>
}

class BrawlerTrophyRepositoryImpl: BrawlerTrophyRepository {
    private let dataSource: BrawlerTrophyDataSource
    
    init(dataSource: BrawlerTrophyDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchBrawlerTrophyData() -> Observable<[TrophyGraphData]> {
        return dataSource.fetchBrawlerTrophyData()
    }
}

protocol BrawlerTrophyUseCase {
    func fetchBrawlerTrophyData() -> Observable<[TrophyGraphData]>
}

class BrawlerTrophyUseCaseImpl: BrawlerTrophyUseCase {
    
    let repository: BrawlerTrophyRepository
    
    init(repository: BrawlerTrophyRepository) {
        self.repository = repository
    }
    
    func fetchBrawlerTrophyData() -> Observable<[TrophyGraphData]> {
        return repository.fetchBrawlerTrophyData()
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
    
    func loadTrophyData() {
        isLoading = true
        errorMessage = nil
        
        useCase.fetchBrawlerTrophyData()
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
    
//    func getRank(for score: Int) -> String {
//        if score >= 1000 {
//            return "tiermax"
//        }
//
//        let rank = score / 20 + 1
//        return "rank\(rank)"
//    }
}
