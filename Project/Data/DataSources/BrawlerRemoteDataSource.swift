//
//  BrawlerRemoteDataSource.swift
//  Brawlytics
//
//  Created by 차상진 on 5/24/25.
//

import Foundation
import RxSwift

protocol BrawlerRemoteDataSource {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void)
}

class BrawlerRemoteDataSourceImpl: BrawlerRemoteDataSource {
    func getUserBrawlers(searchText: String, completion: @escaping ([Brawler]) -> Void) {
        let cleanedSearchText = searchText.hasPrefix("#") ? String(searchText.dropFirst()) : searchText
         guard let url = URL(string: "\(Constants.getBrawlersURL)?playertag=\(cleanedSearchText)") else {
             print("Invalid URL")
             completion([])
             return
         }

         var request = URLRequest(url: url)
         request.httpMethod = "GET"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")

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
                    completion(brawlersResponse)
                     
                    
                 } catch {
                     print("Failed to decode JSON: \(error)")
                     completion([])
                 }
             }.resume()
     }
}


//MARK: - Rx
protocol RxRemoteDataSource {
    func getUserBrawlers(searchText: String) -> Observable<[Brawler]>
}

class RxRemoteDataSourceImpl: RxRemoteDataSource {
    func getUserBrawlers(searchText: String) -> Observable<[Brawler]> {
        return Observable.create { observer in
            let cleanedSearchText = searchText.hasPrefix("#") ? String(searchText.dropFirst()) : searchText
            guard let url = URL(string: "\(Constants.getBrawlersURL)?playertag=\(cleanedSearchText)") else {
                print("Invalid URL")
                observer.onNext([])
                observer.onCompleted()
                return Disposables.create()
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error as? URLError {
                    print("Error fetching brawlers: \(error)")
                    observer.onError(BrawlerFetchError.network)
                    return
                }
               
                guard let data = data else {
                    print("No data received")
                    observer.onNext([])
                    observer.onCompleted()
                    return
                }
               
                do {
                    let brawlersResponse = try JSONDecoder().decode([Brawler].self, from: data)
                    observer.onNext(brawlersResponse)
                    observer.onCompleted()
                } catch let decodingError as DecodingError {
                    print("Failed to decode JSON: \(decodingError)")
                    observer.onError(BrawlerFetchError.decoding)
                } catch {
                    observer.onError(BrawlerFetchError.unknown)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

//MARK: - enum
enum BrawlerFetchError: Error {
    case network
    case decoding
    case unknown
}
