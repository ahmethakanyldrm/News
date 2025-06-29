//
//  NewsViewModel.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

enum Mode: Equatable {
    case top
    case search(String)
}

final class NewsViewModel {
    // MARK: - Properties
    private let newsService: NewsServiceProtocol
    weak var delegate: NewsViewControllerProtocol?
    
    private(set) var articles: [Article] = []
    
    private var mode: Mode = .top
    private let debounceInterval: TimeInterval = 1
    private var debounceWorkItem: DispatchWorkItem?
    
    init(newsService: NewsServiceProtocol = NewsService()) {
        self.newsService = newsService
    }
    
    deinit {
        debounceWorkItem?.cancel()
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
    
    func fetch(){
        let completion: (Result<News,NetworkError>) -> Void = { [weak self] result in
            
            guard let self else {return}
            
            switch result {
            case .success(let news):
                self.articles = news.articles
                self.delegate?.reloadData()
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
        
        switch mode {
        case .top:
            newsService.fetchNews(country: "us", page: 1, pageSize: 100, completion: completion)
        case .search(let query):
            newsService.searchNews(searchQuery: query, page: 1, pageSize: 100, completion: completion)
        }
        
    }
    
    // Search
    func search(term: String) {
        let trimmedTerm = term.trimmingCharacters(in: .whitespacesAndNewlines)
        debounceWorkItem?.cancel()
        
        let workItem = DispatchWorkItem { [weak self] in
            guard let self else { return }
            self.mode = trimmedTerm.isEmpty ? .top : .search(trimmedTerm)
            self.fetch()
        }
        
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval, execute: workItem)
    }
}
