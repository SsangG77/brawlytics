//
//  CalculateViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation
import SwiftUI
import RxSwift

class CalculateViewModel: ObservableObject {
    
    @Published var brawlers: [Brawler] = []
    @Published var isLoading: Bool = false
    private let calculateUseCase: CalculateUseCase
    
    init(calculateUseCase: CalculateUseCase) {
        self.calculateUseCase = calculateUseCase
    }

    
    
    func getBrawlers(_ searchText: String) {
        isLoading = true
        self.calculateUseCase.getUserBrawlers(searchText: searchText) { brawlers in
            DispatchQueue.main.async {
                self.brawlers = brawlers
                self.isLoading = false
            }
        }
    }
    
    func findMyBrawler(brawlerName: String) -> Brawler {
        return calculateUseCase.findMyBrawler(brawlerName: brawlerName)
    }
    
    @ViewBuilder
    func DynamicStack<Content: View>(isPad: Bool, @ViewBuilder content: () -> Content) -> some View {
        if isPad { //아이패드일때
            HStack {
                content()
            }
            .frame(height: 130)
            
        } else {
            ZStack {
                content()
            }
        }
    }
}


//MARK: - rx
class RxCalculateViewModel: ObservableObject {
    @Published var brawlers: [Brawler] = []
    @Published var isLoading: Bool = false
    
    let brawlersSubject = PublishSubject<[Brawler]>()
    private let useCase: RxCalculateUseCase
    private let disposeBag = DisposeBag()
    
    init(useCase: RxCalculateUseCase) {
        self.useCase = useCase
    }
    
    func getBrawlers(_ searchText: String) {
        isLoading = true
        self.useCase.getUserBrawlers(searchText: searchText)
            .observe(on: MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] brawlers in
                    self?.brawlers = brawlers
                    self?.brawlersSubject.onNext(brawlers)
                    self?.isLoading = false
                },
                onError: { [weak self] error in
                    print("Error: \(error)")
                    self?.isLoading = false
                }
            )
            .disposed(by: disposeBag)
    }
    
    func findMyBrawler(brawlerName: String) -> Brawler {
        return useCase.findMyBrawler(brawlerName: brawlerName)
    }
    
    @ViewBuilder
    func DynamicStack<Content: View>(isPad: Bool, @ViewBuilder content: () -> Content) -> some View {
        if isPad { //아이패드일때
            HStack {
                content()
            }
            .frame(height: 130)
            
        } else {
            ZStack {
                content()
            }
        }
    }
    
}

