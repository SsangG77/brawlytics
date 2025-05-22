//
//  SearchHistoryRepository.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import SwiftUI

protocol SearchHistoryRepository {
    func saveSearchText(_ searchText:String)
    func getSearchHistory() -> [String]
}

class SearchHistoryRepositoryImpl: SearchHistoryRepository {
    @AppStorage("searchString") var searchString: [String] = []

    func saveSearchText(_ searchText:String) {
        if !searchString.contains(searchText) {
            if searchString.count >= 3 {
                searchString.removeFirst()
                searchString.append(searchText)
            } else {
                searchString.append(searchText)
            }
        }
    }

    func getSearchHistory() -> [String] {
        return searchString
    }
}
