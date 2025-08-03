//
//  BattleLogViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift

class BattleLogViewModel: ObservableObject {
    
    @Published var battleLog: [BattleLogModel] = []
    @Published var isLoading: Bool = false
    private let disposeBag = DisposeBag()
    let useCase: BattleLogUseCase
    
    init(useCase: BattleLogUseCase) {
        self.useCase = useCase
    }
    
    func fetchBattleLog() {
        isLoading = true
        useCase.fetchBattleLog()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] log in
                self?.battleLog = log
                self?.isLoading = false
            }, onError: { [weak self] error in
                print("Error fetching battle log: \(error)")
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }
    
    func checkMode(mode: String) -> String {
        print(mode)
        return useCase.checkMode(mode: mode)
    }
    
    func getMapName(mapName: String) -> String {
        return useCase.getMapName(mapName: mapName)
    }
    
    func getBattleReults(type: CardType) -> String {
        switch type {
        case .win: return "WIN"
        case .lose: return "LOSE"
        case .draw: return "DRAW"
        default: return ""
        }
    }
}


