//
//  NetworkError.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 25.06.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case decodingError
    case requestFailedWith(Int)
    case invalidResponse
    case customError(Error)
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .decodingError:
            return "Decoding Error"
        case .requestFailedWith(let code):
           return "Request failed with status code \(code)"
        case .invalidResponse:
            return "Invalid Response"
        case .customError(let error):
            return error.localizedDescription
        case .invalidData:
            return "Invalid Data"
        }
    }
    
}
