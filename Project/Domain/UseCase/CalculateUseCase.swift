//
//  CalculateUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation

protocol CalculateUseCase {
    func getBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
    func findMyBrawler(brawlerName: String) -> Brawler

}

class CalculateUseCaseImpl: CalculateUseCase {
    
    var brawlers: [Brawler] = []

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
