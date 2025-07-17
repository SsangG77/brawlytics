//
//  PlayerProfileDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
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
            let cleanedPlayerTag = playerTag.hasPrefix("#") ? String(playerTag.dropFirst()) : playerTag
            
            let url = Constants.fetchUserProfileURL
            let parameters: [String: Any] = ["playertag": cleanedPlayerTag]
            
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: UserTrophyModel.self) { response in
                    switch response.result {
                    case .success(let userProfile):
                    
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
            let cleanedPlayerTag = playerTag.hasPrefix("#") ? String(playerTag.dropFirst()) : playerTag
            
            let url = Constants.fetchBrawlersTrophyURL
            let parameters: [String: Any] = ["playertag": cleanedPlayerTag]
            
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: [BrawlerTrophyModel].self) { response in
                    switch response.result {
                    case .success(let brawlersTrophy):
                        
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
