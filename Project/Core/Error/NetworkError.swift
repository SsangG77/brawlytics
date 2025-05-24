//
//  NetworkError.swift
//  Brawlytics
//
//  Created by 차상진 on 5/24/25.
//

import Foundation

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
