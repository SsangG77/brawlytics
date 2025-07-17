//
//  BattleLogDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift
import Alamofire


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
