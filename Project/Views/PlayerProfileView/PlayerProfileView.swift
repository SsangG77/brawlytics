//
//  PlayerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI
import RxSwift
import Alamofire


//MARK: - DataSource
protocol PlayerProfileDataSource {
    func fetchUserProfile() ->  Observable<UserTrophyModel>
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]>
}

class PlayerProfileRemoteDataSourceImpl: PlayerProfileDataSource {
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return Observable.create { observer in
            guard let playerTag = UserDefaults.standard.string(forKey: "playerTag") else {
                print("PlayerProfileRemoteDataSourceImpl - fetchUserProfile: Player tag not found in UserDefaults")
                observer.onError(NSError(domain: "PlayerProfileError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Player tag not found in UserDefaults"]))
                return Disposables.create()
            }
            
            let url = Constants.fetchUserProfileURL
            let parameters: [String: Any] = ["playerTag": playerTag]
            print("PlayerProfileRemoteDataSourceImpl - fetchUserProfile: Requesting \(url) with parameters: \(parameters)")
            
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: UserTrophyModel.self) { response in
                    switch response.result {
                    case .success(let userProfile):
                        print("PlayerProfileRemoteDataSourceImpl - fetchUserProfile: Success - \(userProfile)")
                        observer.onNext(userProfile)
                        observer.onCompleted()
                    case .failure(let error):
                        print("PlayerProfileRemoteDataSourceImpl - fetchUserProfile: Error - \(error)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return Observable.create { observer in
            guard let playerTag = UserDefaults.standard.string(forKey: "playerTag") else {
                print("PlayerProfileRemoteDataSourceImpl - fetchBrawlersTrophy: Player tag not found in UserDefaults")
                observer.onError(NSError(domain: "PlayerProfileError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Player tag not found in UserDefaults"]))
                return Disposables.create()
            }
            
            let url = Constants.fetchBrawlersTrophyURL
            let parameters: [String: Any] = ["playerTag": playerTag]
            print("PlayerProfileRemoteDataSourceImpl - fetchBrawlersTrophy: Requesting \(url) with parameters: \(parameters)")
            
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: [BrawlerTrophyModel].self) { response in
                    switch response.result {
                    case .success(let brawlersTrophy):
                        print("PlayerProfileRemoteDataSourceImpl - fetchBrawlersTrophy: Success - \(brawlersTrophy)")
                        observer.onNext(brawlersTrophy)
                        observer.onCompleted()
                    case .failure(let error):
                        print("PlayerProfileRemoteDataSourceImpl - fetchBrawlersTrophy: Error - \(error)")
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}


//class MockPlayerProfileDataSourceImpl: PlayerProfileDataSource {
//    func fetchUserProfile() -> Observable<UserTrophyModel> {
//        return Observable.just(
//            UserTrophyModel(
//               nickName: "상진",
//               club: "팀",
////               rank: "diamond",
//               total: 9200,
//               max: 10000
//            )
//        )
//    }
//    
//    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
//        return Observable.just([
//            BrawlerTrophyModel(name: "Shelly", rank: 51, currentTrophy: 540, highestTrophy: 900),
//            BrawlerTrophyModel(name: "Bull", rank: 50, currentTrophy: 140, highestTrophy: 500),
//            BrawlerTrophyModel(name: "Kaze", rank: 21, currentTrophy: 220, highestTrophy: 590),
//            BrawlerTrophyModel(name: "Penny", rank: 11, currentTrophy: 190, highestTrophy: 503),
//            
//        ])
//    }
//}


protocol PlayerProfileRepository {
    func fetchUserProfile() -> Observable<UserTrophyModel>
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]>
}

class PlayerProfileRepositoryImpl: PlayerProfileRepository {
    let dataSource: PlayerProfileDataSource
    
    init(dataSource: PlayerProfileDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return dataSource.fetchUserProfile()
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return dataSource.fetchBrawlersTrophy()
    }
}


protocol PlayerProfileUseCase {
    func fetchUserProfile() -> Observable<UserTrophyModel>
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]>
    func groupByRole(brawlers: [BrawlerTrophyModel]) -> [Role: [BrawlerTrophyModel]]
}

class PlayerProfileUseCaseImpl: PlayerProfileUseCase {
    
    private let roleToNames: [Role: [String]] = [
            .tanker: ["Bull", "El Primo", "Rosa", "Darryl", "Jackey", "Frank", "Bibi", "Ash", "Hank", "Buster", "Ollie", "Meg", "Draco"],
            .assassin: ["Stu", "Edgar", "Sam", "Shade", "Mortis", "Buzz", "Fang", "Mico", "Melodie", "Lily", "Crow", "Leon", "Cordelius", "Kenji", "Kaze", "Alli"],
            .supporter: ["Poco", "Gus", "Pam", "Berry", "Max", "Byron", "Ruffs", "Gray", "Doug", "Kit", "Jae-Yong"],
            .controller: ["Jessie", "Penny", "Bo", "Emz", "Griff", "Gale", "Meeple", "Gene", "Mr. p", "Squeak", "Lou", "Otis", "Willow", "Chuck", "Charlie", "Sandy", "Amber", "Finx"],
            .damageDealer: ["Shelly", "Nita", "Colt", "8-bit", "Rico", "Carl", "Colette", "Lola", "Pearl", "Tara", "Eve", "R-t", "Clancy", "Moe", "Spike", "Surge", "Chester", "Lumi"],
            .marksmen: ["Brock", "Nani", "Mandy", "Maisie", "Belle", "Bonnie", "Bea", "Angelo", "Janet", "Piper"],
            .thrower: ["Barley", "Dynamike", "Tick", "Grom", "Larry & Lawrie", "Sprout", "Juju"]
       ]
    
    private let repository: PlayerProfileRepository
    
    init(repository: PlayerProfileRepository) {
        self.repository = repository
    }
    
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return repository.fetchUserProfile()
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return repository.fetchBrawlersTrophy()
    }
    
    func groupByRole(brawlers: [BrawlerTrophyModel]) -> [Role: [BrawlerTrophyModel]] {
        var result: [Role: [BrawlerTrophyModel]] = [:]
        for (role, names) in roleToNames {
            result[role] = brawlers.filter { names.contains($0.name) }
        }
        return result
    }
    
}


class PlayerProfileViewModel: ObservableObject {
    private let useCase: PlayerProfileUseCase
    private let disposeBag = DisposeBag()
    
    @Published var user: UserTrophyModel?
    @Published var groupedBrawlers: [Role: [BrawlerTrophyModel]] = [:]
    @Published var brawlers: [BrawlerTrophyModel]?
    
    init(useCase: PlayerProfileUseCase) {
        self.useCase = useCase
    }
    
    func fetchUserProfile() {
        useCase.fetchUserProfile()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.user = user
            })
            .disposed(by: disposeBag)
    }
    
    func fetchBrawlersTrophy() {
        useCase.fetchBrawlersTrophy()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] brawlers in
                self?.groupedBrawlers = self?.useCase.groupByRole(brawlers: brawlers) ?? [:]
            })
            .disposed(by: disposeBag)
        
    }
}


//유저 정보 카드 뷰
struct PlayerProfileView: View {
    
    @ObservedObject var vm: PlayerProfileViewModel
    let classTitleVM = ClassesTitleViewModel()
    let brawlerTrophyVM = RxDIContainer.shared.makeBrawlerTrophyViewModel()
    
    init(vm: PlayerProfileViewModel) {
        self.vm = vm
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .center, spacing: 24) {
                        userSection()
                        brawlerSection()
                    }
                    .padding()
                }
            }
            .onAppear {
                let savedPlayerTag = UserDefaults.standard.string(forKey: "playerTag") ?? "(없음)"
                print("PlayerProfileView onAppear - UserDefaults playerTag: \(savedPlayerTag)")
                vm.fetchUserProfile()
                vm.fetchBrawlersTrophy()
            }
        }
    }
    
    
    @ViewBuilder
    private func userSection() -> some View {
        if let user = vm.user {
            NavigationLink(destination: BattleLogView(
                vm: RxDIContainer.shared.makeBattleLogViewModel()
            )) {
                UserView(user: user)
            }
        } else {
            VStack {
                Spacer()
                Text("설정에서 플레이어 태그를 입력해주세요")
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func brawlerSection() -> some View {
        ScrollView {
            LazyVStack(alignment: .center, spacing: 16) {
                let grouped = vm.groupedBrawlers
                let order: [Role] = [.tanker, .assassin, .supporter, .controller, .damageDealer, .marksmen, .thrower]

                let sortedRoles = grouped.keys.sorted {
                    order.firstIndex(of: $0)! < order.firstIndex(of: $1)!
                }

                ForEach(Array(sortedRoles), id: \.self) { role in
                    brawlerSectionView(for: role, brawlers: grouped[role] ?? [])
                }
            }
            .padding(.vertical)
        }
    }

    @ViewBuilder
    private func brawlerSectionView(for role: Role, brawlers: [BrawlerTrophyModel]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ClassesTitleView(
                imageName: classTitleVM.getImageName(role: role),
                title: classTitleVM.getClassTitle(role: role)
            )
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(brawlers) { brawler in
                        NavigationLink(destination: TrophyGraphView(
                            brawlerTrophyModel: brawler,
                            vm: brawlerTrophyVM
                        )) {
                            BrawlerTrophyView(
                                brawlerTrophyModel: brawler,
                                vm: brawlerTrophyVM
                            )
                                .scrollTargetLayout()
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 210)
            .scrollTargetBehavior(.viewAligned)
        }
    }

}


#Preview {
    PlayerProfileView(
        vm: RxDIContainer.shared.makePlayerProfileViewModel()
    )
}
