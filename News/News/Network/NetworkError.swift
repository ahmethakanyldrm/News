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
    case invalidResponse
    case customError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .decodingError:
            return "Decoding Error"
        case .invalidResponse:
            return "Invalid Response"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}
