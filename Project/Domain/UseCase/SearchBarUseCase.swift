//
//  SearchBarUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import SwiftUI

protocol SearchBarUseCase {
    func saveSearchText(_ searchText: String)
    func getSearchHistory() -> [String]
    func clearSearchHistory()
}

class SearchBarUseCaseImpl: SearchBarUseCase {
    
    let historyRepository : SearchHistoryRepository
    
    init(historyRepository: SearchHistoryRepository) {
        self.historyRepository = historyRepository
    }
    
    func saveSearchText(_ searchText: String) {
        historyRepository.saveSearchText(searchText)
    }
    
    func getSearchHistory() -> [String] {
        return historyRepository.getSearchHistory()
    }
    
    func clearSearchHistory() {
        historyRepository.clearSearchHistory()
    }
}
