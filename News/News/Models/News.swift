//
//  News.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 25.06.2025.
//

import Foundation

struct News: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
    let author: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}
