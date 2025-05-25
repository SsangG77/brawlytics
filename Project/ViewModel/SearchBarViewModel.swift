//
//  SearchBarViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation
import RxSwift
import RxCocoa

class SearchBarViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchHistory: [String] = []
    
    private let historyRepository: SearchHistoryRepository
    private let disposeBag = DisposeBag()
    let searchTextSubject = BehaviorSubject<String>(value: "")
    
    init(repository: SearchHistoryRepository) {
        self.historyRepository = repository
        setupBindings()
    }
    
    private func setupBindings() {
        searchTextSubject
            .asObservable()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.searchText = text
            })
            .disposed(by: disposeBag)
    }
    
    func saveSearchText(_ searchText: String) {
        historyRepository.saveSearchText(searchText)
        searchHistory = historyRepository.getSearchHistory()
    }
    
    func getSearchHistory() -> [String] {
        return historyRepository.getSearchHistory()
    }
    
    func updateSearchText(_ text: String) {
        searchTextSubject.onNext(text)
    }
}
