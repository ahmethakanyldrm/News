//
//  NewsViewModel.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

final class NewsViewModel {
    // MARK: - Properties
    private let newsService: NewsServiceProtocol
    weak var delegate: NewsViewControllerProtocol?
    
    private(set) var articles: [Article] = []
    
    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
    }
}

// MARK: - Extension

extension NewsViewModel {
    func fetchNews() {
        newsService.fetchNews(country: "us", page: 1, pageSize: 100) { [weak self] result in
            guard let self else {return}
            
            switch result {
            case .success(let news):
                self.articles = news.articles
                self.delegate?.reloadData()
                
            case .failure(let error):
                print("Failed to fetch news \(error.localizedDescription)")
            }
        }
    }
}
