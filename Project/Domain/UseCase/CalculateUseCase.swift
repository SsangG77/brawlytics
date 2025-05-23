//
//  CalculateUseCase.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation



// Core/Error/NetworkError.swift
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
    
    var message: String {
        switch self {
        case .invalidURL:
            return "잘못된 URL입니다."
        case .noData:
            return "데이터를 받아오지 못했습니다."
        case .decodingError:
            return "데이터 변환에 실패했습니다."
        case .serverError(let message):
            return message
        }
    }
}




protocol BrawlerRemoteDataSource {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
}

class BrawlerRemoteDataSourceImpl: BrawlerRemoteDataSource {

    
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
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
//                    self.brawlers = brawlersResponse
                    completion(brawlersResponse)
                     
                    
                 } catch {
                     print("Failed to decode JSON: \(error)")
                     completion([])
                 }
             }.resume()
         }
        
     }//
}





protocol RemoteRepository {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
}

class RemoteRepositoryImpl: RemoteRepository {
    private let remoteDataSource: BrawlerRemoteDataSource
    
    init(remoteDataSource: BrawlerRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
        remoteDataSource.getUserBrawlers(searchText: searchText, completion: completion)
    }
    
}



protocol CalculateUseCase {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
    func findMyBrawler(brawlerName: String) -> Brawler

}

class CalculateUseCaseImpl: CalculateUseCase {
    
    var brawlers: [Brawler] = []
    let repository: RemoteRepository
    
    init (repository: RemoteRepository) {
        self.repository = repository
    }
    
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
           repository.getUserBrawlers(searchText: searchText) { [weak self] brawlers in
               self?.brawlers = brawlers
               completion(brawlers)
           }
       }

    func findMyBrawler(brawlerName: String) -> Brawler {
        return brawlers.first(where: { $0.name == brawlerName }) ?? Brawler()
    }
}
