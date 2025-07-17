//
//  MockSearchHistoryRepository.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 5/28/25.
//

import Foundation
@testable import Brawlytics
class MockSearchBarUseCase: SearchBarUseCase {
    var searchHistory: [String] = []
    
    func saveSearchText(_ searchText: String) {
        print("test : \(searchText)")
        searchHistory.append(searchText)
    }
    
    func getSearchHistory() -> [String] {
        return searchHistory
    }
    
    func clearSearchHistory() {
        searchHistory = []
    }
}
