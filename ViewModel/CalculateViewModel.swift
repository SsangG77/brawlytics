//
//  CalculateViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation
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

protocol CalculateUseCase {
    func getBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
    func findMyBrawler(brawlerName: String) -> Brawler

    func saveSearchText(_ searchText:String)
    func getSearchHistory() -> [String]
}

class CalculateUseCaseImpl: CalculateUseCase {
    
    var brawlers: [Brawler] = []
    private let searchHistoryRepository: SearchHistoryRepository

    init(searchHistoryRepository: SearchHistoryRepository) {
        self.searchHistoryRepository = searchHistoryRepository
    }

    func saveSearchText(_ searchText:String) {
        searchHistoryRepository.saveSearchText(searchText)
    }

    func getSearchHistory() -> [String] {
        return searchHistoryRepository.getSearchHistory()
    }

    func getBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
         guard let url = URL(string: "\(Constants.getBrawlersURL)?playertag=\(searchText)") else {
             print("Invalid URL")
             completion([])
             return
         }

         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")

         DispatchQueue.global().async {
            
             URLSession.shared.dataTask(with: request) { data, response, error in
                 if let error = error {
                     print("Error fetching brawlers: \(error)")
                     completion([])
                     return
                 }
                
                 guard let data = data else {
                     print("No data received")
                     completion([])
                     return
                 }
                
                 do {
                     let brawlersResponse = try JSONDecoder().decode([Brawler].self, from: data)
                    self.brawlers = brawlersResponse
                    completion(brawlersResponse)
                     
                    
                 } catch {
                     print("Failed to decode JSON: \(error)")
                     completion([])
                 }
             }.resume()
         }
        
     }

    func findMyBrawler(brawlerName: String) -> Brawler {
        return brawlers.first(where: { $0.name == brawlerName }) ?? Brawler()
    }
}


class CalculateViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var brawlers: [Brawler] = []
    @Published var isLoading: Bool = false
    @Published var searchHistory: [String] = []
    
    private let calculateUseCase: CalculateUseCase
    
    init(calculateUseCase: CalculateUseCase) {
        self.calculateUseCase = calculateUseCase
        self.searchHistory = calculateUseCase.getSearchHistory()
    }

    func saveSearchText(_ searchText:String) {
        calculateUseCase.saveSearchText(searchText)
        self.searchHistory = calculateUseCase.getSearchHistory()
    }
    
    
    func getBrawlers() {
        isLoading = true
        self.calculateUseCase.getBrawlers(searchText: searchText) { brawlers in
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
