//
//  NewsService.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchNews(country: String, page: Int,pageSize: Int, completion: @escaping(Result<News,NetworkError>)-> Void)
}

final class NewsService: NewsServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchNews(country: String, page: Int,pageSize: Int, completion: @escaping(Result<News,NetworkError>)-> Void) {
        
        var urlComponents = URLComponents(string: NetworkConstants.baseUrl + "top-headlines")
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "apiKey", value: NetworkConstants.apiKey)
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidRequest))
            return
        }
        networkManager.request(url: url, method: .GET, completion: completion)
        
    }
        
}
