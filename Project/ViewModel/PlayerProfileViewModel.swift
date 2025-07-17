//
//  PlayerProfileViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import RxSwift


class PlayerProfileViewModel: ObservableObject {
    private let useCase: PlayerProfileUseCase
    private let disposeBag = DisposeBag()
    
    @Published var user: UserTrophyModel?
    @Published var groupedBrawlers: [Role: [BrawlerTrophyModel]] = [:]
    @Published var brawlers: [BrawlerTrophyModel]?
    @Published var isLoading: Bool = false
    
    init(useCase: PlayerProfileUseCase) {
        self.useCase = useCase
    }
    
    func fetchUserProfile() {
        isLoading = true
        useCase.fetchUserProfile()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.user = user
                self?.isLoading = false
            }, onError: { [weak self] error in
                print("Error fetching user profile: \(error)")
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
    }
    
    func fetchBrawlersTrophy() {
        isLoading = true
        useCase.fetchBrawlersTrophy()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] brawlers in
                self?.groupedBrawlers = self?.useCase.groupByRole(brawlers: brawlers) ?? [:]
                self?.isLoading = false
            }, onError: { [weak self] error in
                print("Error fetching brawlers trophy: \(error)")
                self?.isLoading = false
            })
            .disposed(by: disposeBag)
        
    }
}
