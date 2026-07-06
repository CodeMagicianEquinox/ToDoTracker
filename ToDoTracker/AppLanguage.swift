//
//  AppLanguage.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 7/2/26.
//

import Foundation

enum AppLanguage: String, CaseIterable, Identifiable {
    case system
    case english
    case spanish
    case french

    var id: String { rawValue }

    var locale: Locale {
        switch self {
        case .system:
            return .autoupdatingCurrent
        case .english:
            return Locale(identifier: "en_US")
        case .spanish:
            return Locale(identifier: "es_ES")
        case .french:
            return Locale(identifier: "fr_FR")
        }
    }

    var title: String {
        switch self {
        case .system:
            return String(localized: "System Default")
        case .english:
            return String(localized: "English")
        case .spanish:
            return String(localized: "Spanish")
        case .french:
            return String(localized: "French")
        }
    }

    var sampleDataLocale: Locale {
        locale
    }

    var resourceImageName: String {
        switch self {
        case .system:
            return AppLanguage.resourceImageName(for: .autoupdatingCurrent)
        case .english:
            return "locale-banner-en"
        case .spanish:
            return "locale-banner-es"
        case .french:
            return "locale-banner-fr"
        }
    }

    static func resourceImageName(for locale: Locale) -> String {
        switch locale.language.languageCode?.identifier {
        case "es":
            return "locale-banner-es"
        case "fr":
            return "locale-banner-fr"
        default:
            return "locale-banner-en"
        }
    }
}
