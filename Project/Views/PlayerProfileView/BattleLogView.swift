//
//  BattleLogView.swift
//  Brawlytics
//
//  Created by 차상진 on 6/23/25.
//

import SwiftUI
import RxSwift
import Alamofire


struct BattleLogModel: Identifiable, Codable {
    var id = UUID()
    let result: String
    let mode: String
    let mapName: String
    let date: String
    let teams: [Team]
}

struct Team: Identifiable, Codable {
    var id = UUID()
    let member: [Member]
}

struct Member: Identifiable, Codable {
    var id = UUID()
    var name: String
    var brawler: String
    var power: Int
    var starPlayer: Bool
}





protocol BattleLogDataSource {
    func fetchBattleLog() -> Observable<[BattleLogModel]>
}

class BattleLogRemoteDataSourceImpl: BattleLogDataSource {
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return Observable.create { observer in
            guard let playerTag = UserDefaults.standard.string(forKey: "playerTag") else {
                observer.onError(NSError(domain: "BattleLogError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Player tag not found in UserDefaults"]))
                return Disposables.create()
            }
            let cleanedPlayerTag = playerTag.hasPrefix("#") ? String(playerTag.dropFirst()) : playerTag
            
            let url = Constants.fetchBattleLogURL
            let parameters: [String: Any] = ["playertag": cleanedPlayerTag]
            
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: [BattleLogModel].self) { response in
                    switch response.result {
                    case .success(let battleLogs):
                        Constants.myPrint(title: "/battlelog", content: battleLogs)
                        observer.onNext(battleLogs)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}

class MockBattleLogDataSourceImpl: BattleLogDataSource {
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return Observable.just([
            
            BattleLogModel(
                result: "showdown", mode: "trioShowdown", mapName: "1", date: "2024/03/21",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    ),
                ]
            ),
            
            BattleLogModel(
                result: "win", mode: "brawlBall", mapName: "1", date: "2024/03/21",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: true),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    )
                ]
            ),
            BattleLogModel(
                result: "lose", mode: "brawlBall", mapName: "2", date: "2024/03/22",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: true),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    )
                ]
            ),
            BattleLogModel(
                result: "win", mode: "brawlBall", mapName: "3", date: "2024/03/24",
                teams: [
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: true),
                        ]
                    ),
                    Team(
                        member: [
                            Member(name: "A", brawler: "Gale", power: 11, starPlayer: false),
                            Member(name: "B", brawler: "Kenji", power: 1, starPlayer: false),
                            Member(name: "C", brawler: "Kaze", power: 6, starPlayer: false),
                        ]
                    )
                ]
            )
        ])
    }
}




protocol BattleLogRepository {
    func fetchBattleLog() -> Observable<[BattleLogModel]>
}

class BattleLogRepositoryImpl: BattleLogRepository {
    let dataSource: BattleLogDataSource
    
    init(dataSource: BattleLogDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return dataSource.fetchBattleLog()
    }
}


protocol BattleLogUseCase {
    func checkMode(mode: String) -> String
    func fetchBattleLog() -> Observable<[BattleLogModel]>
}

class BattleLogUseCaseImpl: BattleLogUseCase {
    let repository: BattleLogRepository
    
    init(repository: BattleLogRepository) {
        self.repository = repository
    }
    
    
    
    func checkMode(mode: String) -> String {
        switch mode {
        case "gemGrab": return "gem_grab_icon"
        case "bounty": return "bounty_icon"
        case "brawlBall": return "brawl_ball_icon"
        case "heist": return "heist_icon"
        case "hotZone": return "hot_zone_icon"
        case "knockOut": return "knock_out_icon"
        case "trioShowdown", "duoShowdown", "showdown": return "showdown_icon"
        case "duels": return "duels_icon"
            
        default: return ""
        }
    }
    
    func fetchBattleLog() -> Observable<[BattleLogModel]> {
        return repository.fetchBattleLog()
            .map { battleLogs in
               // 날짜 내림차순으로 정렬 (최신 날짜가 맨 앞에)
               return battleLogs.sorted { first, second in
                   let firstDate = self.parseDate(from: first.date)
                   let secondDate = self.parseDate(from: second.date)
                   return firstDate > secondDate // 내림차순 정렬
               }
           }
    }
    
    // 날짜 문자열을 Date 객체로 변환하는 private 메서드
    private func parseDate(from dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.date(from: dateString) ?? Date.distantPast
    }
}


class BattleLogViewModel: ObservableObject {
    
    @Published var battleLog: [BattleLogModel] = []
    private let disposeBag = DisposeBag()
    let useCase: BattleLogUseCase
    
    init(useCase: BattleLogUseCase) {
        self.useCase = useCase
    }
    
    func fetchBattleLog() {
        useCase.fetchBattleLog()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] log in
                self?.battleLog = log
            })
            .disposed(by: disposeBag)
    }
    
    func checkMode(mode: String) -> String {
        return useCase.checkMode(mode: mode)
    }
}

struct BattleLogView: View {
    
    @ObservedObject var vm: BattleLogViewModel
    
    init(vm: BattleLogViewModel) {
        self.vm = vm
    }
    
    
    var body: some View {
        ZStack {
            Color.backgroundColor // 배경 뷰 (예: 색상)
                .ignoresSafeArea() // 화면 전체로 확장
            
            ScrollView {            
                LazyVStack(spacing: 12) {
                    ForEach(vm.battleLog) { log in
                        SingleBattleLogView(log: log, vm: vm)
                    }
                }
            }
            
        }
        .navigationTitle("Battle Logs")
        .navigationBarTitleDisplayMode(.large) // 선택 사항
        .onAppear {
            vm.fetchBattleLog()
        }
    }
}



struct SingleBattleLogView: View {
    
    let overlapCardVM: OverlapCardViewModel
    let vm: BattleLogViewModel
    let log: BattleLogModel
    
    init(log: BattleLogModel, vm: BattleLogViewModel) {
        #warning("overlapCardVM 타입 쇼다운 경우도 처리")
        self.overlapCardVM = OverlapCardViewModel(type: log.result == "win" ? .win : .lose)
        self.vm = vm
        self.log = log
    }
    
    
    var body: some View {
        OverlapCardView(vm: overlapCardVM, frontView: {
            logView
        }, backView: {
           header
        })
    }
    
    
    var header: some View {
        HStack(spacing: 0) {
            
            Image(vm.checkMode(mode: log.mode))
                .resizable()
                .scaledToFit()
                .frame(width: 40)
            
            VStack(spacing: 5) {
                    Text(log.mapName)
                        .lineLimit(1) // 한 줄로 제한
                        .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                        .font(.title3)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                
                    Text(log.date)
                        .foregroundStyle(Color(hexString: "FFFFFF", opacity: 0.7))
                        .lineLimit(1) // 한 줄로 제한
                        .minimumScaleFactor(0.5) // 최소 50% 크기까지 축소
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
            }
            .padding(.leading, 15)
            
            Spacer()
            
#warning("타입 쇼다운 경우도 처리")
            Text(overlapCardVM.type == .win ? "WIN" : "LOSE")
                .fontWeight(.bold)
                .font(.system(size: 37))
                .foregroundStyle(overlapCardVM.fontColor)
        }
        .padding(.horizontal, 25)
    }
    
    var logView: some View {
        
        Group {
            if overlapCardVM.isPad {
                HStack(spacing: 0) {
                    team(members: log.teams[0].member)
                    Text("VS")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .padding([.top, .bottom], 6)
                    team(members: log.teams[1].member)
                }
            } else {
                VStack(spacing: 0) {
                    
                    team(members: log.teams[0].member)
#warning("쇼다운일때는 VS 삭제")
                    Text("VS")
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .padding([.top, .bottom], 6)
                    team(members: log.teams[1].member)
                }
            }
        }
       
    }
    
    func team(members: [Member]) -> some View {
        HStack {
            ForEach(members.indices, id: \.self) { index in
                member(members[index])
                if index != members.count - 1 {
                    Spacer()
                }
            }
        }
        .padding([.leading, .trailing], 25)
    }
    
    private func member(_ member: Member) -> some View {
        VStack(spacing: 0) {
            Image(member.brawler.uppercased())
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, alignment: .trailing) // ✅ 오른쪽 정렬
            
            Text(member.name)
                .font(.system(size: 10))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 23)
                .padding(2)
        }
        .frame(width: 80, height: 100)
        .clipped()
        .roundedCornerWithBorder(
            lineWidth: 3,
            borderColor: member.starPlayer ? .yellow : .clear,
            backgroundColor: Color(hexString: "FFFFFF", opacity: 0.5),
            radius: 12
        )
    }
}

#Preview {
    BattleLogView(
        vm: RxDIContainer.shared.makeBattleLogViewModel()
    )
}
