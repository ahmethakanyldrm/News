//
//  String.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

extension String {
    /// News API'den gelen tarih stringini okunabilir formatta döndürür.
    /// Örn: "2025-06-29T09:30:00Z" → "29 Haziran 2025, 12:30"
    func toReadableNewsDate(locale: Locale = Locale(identifier: "tr_TR"),
                             timeZone: TimeZone = .current,
                             outputFormat: String = "dd MMMM yyyy, HH:mm") -> String {
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let date = isoFormatter.date(from: self) else {
            // Bazı API'ler fractional seconds vermez; fallback:
            isoFormatter.formatOptions = [.withInternetDateTime]
            guard let fallbackDate = isoFormatter.date(from: self) else {
                return "Geçersiz tarih"
            }
            return fallbackDate.formattedString(format: outputFormat, locale: locale, timeZone: timeZone)
        }

        return date.formattedString(format: outputFormat, locale: locale, timeZone: timeZone)
    }
}


