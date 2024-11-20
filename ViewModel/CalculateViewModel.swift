//
//  CalculateViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation


class CalculateViewModel: ObservableObject {
    
    @Published var searchText: String = "22yjv82rp"
    
    @Published var brawlers: [Brawler] = []
    
    
    func saveSearchText(_ searchText:String) {
        
    }
    
    
    func getBrawlers(/*completion: @escaping () -> Void*/) {
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
                        self.brawlers = brawlersResponse
                        
//                        DispatchQueue.main.async {
//                            completion()
//                        }
                        
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }.resume()
        }
        
    }
    
   
    
    
    
    
    
}
