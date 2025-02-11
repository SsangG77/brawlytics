//
//  CalculateViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation
import SwiftUI


class CalculateViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var brawlers: [Brawler] = []
    
    @Published var isLoading: Bool = false
    
    @Published var searchHistory: [String] = []
    
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
    
    
    
    
    func getBrawlers() {
        guard let url = URL(string: "\(Constants.getBrawlersURL)?playertag=\(searchText)") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        DispatchQueue.global().async {
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error fetching brawlers: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let brawlersResponse = try JSONDecoder().decode([Brawler].self, from: data)
                    
                    DispatchQueue.main.async {
                        withAnimation{ self.brawlers = brawlersResponse }
                    }
                    
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }.resume()
        }
        
    }
    
    
    func findMyBrawler(brawlerName: String) -> Brawler {

        for brawler in self.brawlers {
            if brawler.name == brawlerName {
                return brawler
            }
        }
        return Brawler()
        
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
