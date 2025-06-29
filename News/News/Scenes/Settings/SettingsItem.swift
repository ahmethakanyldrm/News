//
//  SettingsItem.swift
//  News
//
//  Created by AHMET HAKAN YILDIRIM on 29.06.2025.
//

import Foundation

enum SettingsItemType {
    case theme
    case notification
    case rateApp
    case privacyPolicy
    case termsOfUse
}

struct SettingsItem {
    let type: SettingsItemType
    let title: String
    let iconName: String
}

struct SettingsSection {
    let title: String
    let items: [SettingsItem]
    
    static let sections: [SettingsSection] = [
        SettingsSection(title: "Appearance", items: [
            SettingsItem(type: .theme, title: "App Theme", iconName: "circle.righthalf.filled")
        ]),
        SettingsSection(title: "Notifications", items: [
            SettingsItem(type: .notification, title: "Notification", iconName: "bell.fill")
        ]),
        SettingsSection(title: "Rate Us", items: [
            SettingsItem(type: .rateApp, title: "Rate Us", iconName: "star.fill")
        ]),
        SettingsSection(title: "Legal", items: [
            SettingsItem(type: .privacyPolicy, title: "Privacy Policy", iconName: "text.document.fill"),
            SettingsItem(type: .termsOfUse, title: "Terms Of Use", iconName: "checkmark.shield.fill")
        ])
    ]
}
