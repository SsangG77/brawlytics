//
//  PlayerProfileView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/19/25.
//

import SwiftUI
import RxSwift


//MARK: - DataSource
protocol PlayerProfileDataSource {
    func fetchUserProfile() ->  Observable<UserTrophyModel>
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]>
}


class MockPlayerProfileDataSourceImpl: PlayerProfileDataSource {
    func fetchUserProfile() -> Observable<UserTrophyModel> {
        return Observable.just(
            UserTrophyModel(
               nickName: "상진",
               club: "팀",
               rank: "diamond",
               total: 9200,
               max: 10000
            )
        )
    }
    
    func fetchBrawlersTrophy() -> Observable<[BrawlerTrophyModel]> {
        return Observable.just([
            BrawlerTrophyModel(name: "Shelly", currentTrophy: 540, highestTrophy: 900),
            BrawlerTrophyModel(name: "Bull", currentTrophy: 140, highestTrophy: 500),
            BrawlerTrophyModel(name: "Kaze", currentTrophy: 220, highestTrophy: 590),
            BrawlerTrophyModel(name: "Penny", currentTrophy: 190, highestTrophy: 503),
            
        ])
    }
    
}


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
    
    init(vm: PlayerProfileViewModel) {
        self.vm = vm
    }
    
    
    @ViewBuilder
    private func userSection() -> some View {
        if let user = vm.user {
            NavigationLink(destination: BattleLogView()) {
                UserView(user: user)
            }
        } else {
            Text("Network Error")
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
                        NavigationLink(destination: TrophyGraphView()) {
                            BrawlerTrophyView(brawlerTrophyModel: brawler)
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
                vm.fetchUserProfile()
                vm.fetchBrawlersTrophy()
            }
        }
    }

}


#Preview {
    PlayerProfileView(
        vm: PlayerProfileViewModel(
            useCase: PlayerProfileUseCaseImpl(
                repository: PlayerProfileRepositoryImpl(
                    dataSource: MockPlayerProfileDataSourceImpl()
                )
            )
        )
    )
}
