//
//  SearchBarViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.

import Foundation
import RxSwift
import RxCocoa

class SearchBarViewModel: ObservableObject {
//    @Published var searchText: String = ""
    @Published var searchHistory: [String] = []
    
//    private let historyRepository: SearchHistoryRepository
    private let disposeBag = DisposeBag()
    
    // Rx Subjects
    let searchTextSubject = BehaviorSubject<String>(value: "")
    let searchButtonTapped = PublishSubject<Void>()
    // let isLoading = BehaviorSubject<Bool>(value: false)
    
    
    let useCase: SearchBarUseCase
    
    init(useCase: SearchBarUseCase) {
        self.useCase = useCase
        setupBindings()
    }
    
    private func setupBindings() {
        // 검색어 처리
        searchTextSubject
            .asObservable()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
//                self?.searchText = text
                self?.objectWillChange.send()
            })
            .disposed(by: disposeBag)
            
        // 검색 버튼 클릭 처리
        searchButtonTapped
            .withLatestFrom(searchTextSubject)
            .filter { !$0.isEmpty }
            .subscribe(onNext: { [weak self] text in
                self?.saveSearchText(text)
            })
            .disposed(by: disposeBag)
    }
    
    
    func saveSearchText(_ searchText: String) {
        useCase.saveSearchText(searchText)
        searchHistory = self.getSearchHistory()
    }
    
    func getSearchHistory() -> [String] {
        return useCase.getSearchHistory()
    }
    
    func updateSearchText(_ text: String) {
        searchTextSubject.onNext(text)
    }
    
    func triggerSearch() {
        searchButtonTapped.onNext(())
    }
}
