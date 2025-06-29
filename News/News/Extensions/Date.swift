//
//  Date.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

extension Date {
    /// Date nesnesini verilen formata göre stringe çevirir.
    func formattedString(format: String, locale: Locale = Locale(identifier: "tr_TR"), timeZone: TimeZone = .current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = locale
        formatter.timeZone = timeZone
        return formatter.string(from: self)
    }
}
