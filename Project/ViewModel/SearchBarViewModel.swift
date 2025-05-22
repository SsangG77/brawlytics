//
//  SearchBarViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation


class SearchBarViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchHistory: [String] = []
    
    private let historyRepository: SearchHistoryRepository
    
    init(repository: SearchHistoryRepository) {
        self.historyRepository = repository
    }
    
    
    func saveSearchText(_ searchText: String) {
        historyRepository.saveSearchText(searchText)
    }
    
    func getSearchHistory() -> [String] {
        return historyRepository.getSearchHistory()
    }
}
