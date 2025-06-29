//
//  SettingsViewModel.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

final class SettingsViewModel {
    // MARK: - Properties
    var sections = SettingsSection.sections
    private let themeKey = "themeKey"
    
    // MARK: Init
    init() {
        
    }
}

// MARK: - Methods

 extension SettingsViewModel {
    func fetchThemeMode() -> Int {
        UserDefaults.standard.integer(forKey: themeKey)
    }
}
