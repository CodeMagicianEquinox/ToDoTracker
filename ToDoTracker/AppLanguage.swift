//
//  AppLanguage.swift
//  ToDoTracker
//
//  Created by Tim Terrance on 7/2/26.
//

import SwiftUI

enum AppLanguage: String, CaseIterable, Identifiable {
    case system
    case english
    case spanish
    case french
    case arabic

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
        case .arabic:
            return Locale(identifier: "ar_SA")
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
        case .arabic:
            return String(localized: "Arabic")
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
        case .arabic:
            return "locale-banner-ar"
        }
    }

    static func resourceImageName(for locale: Locale) -> String {
        switch locale.language.languageCode?.identifier {
        case "ar":
            return "locale-banner-ar"
        case "es":
            return "locale-banner-es"
        case "fr":
            return "locale-banner-fr"
        default:
            return "locale-banner-en"
        }
    }

    var layoutDirection: LayoutDirection {
        isRightToLeft ? .rightToLeft : .leftToRight
    }

    var isRightToLeft: Bool {
        switch self {
        case .arabic:
            return true
        case .system:
            let code = Locale.autoupdatingCurrent.language.languageCode?.identifier
            return ["ar", "he", "fa", "ur"].contains(code)
        case .english, .spanish, .french:
            return false
        }
    }

    var theme: LocaleTheme {
        switch self {
        case .system:
            return AppLanguage.theme(for: .autoupdatingCurrent)
        case .arabic:
            return LocaleTheme(
                pageBackground: Color(red: 0.95, green: 0.97, blue: 0.93),
                panelBackground: Color(red: 0.98, green: 0.96, blue: 0.88),
                accent: Color(red: 0.05, green: 0.42, blue: 0.30),
                secondaryAccent: Color(red: 0.74, green: 0.55, blue: 0.16)
            )
        case .spanish:
            return LocaleTheme(
                pageBackground: Color(red: 1.0, green: 0.96, blue: 0.86),
                panelBackground: Color(red: 1.0, green: 0.99, blue: 0.94),
                accent: Color(red: 0.76, green: 0.16, blue: 0.12),
                secondaryAccent: Color(red: 0.85, green: 0.45, blue: 0.08)
            )
        case .french:
            return LocaleTheme(
                pageBackground: Color(red: 0.95, green: 0.97, blue: 1.0),
                panelBackground: Color(red: 0.99, green: 0.99, blue: 1.0),
                accent: Color(red: 0.11, green: 0.30, blue: 0.67),
                secondaryAccent: Color(red: 0.72, green: 0.12, blue: 0.18)
            )
        case .english:
            return LocaleTheme(
                pageBackground: Color(red: 0.95, green: 0.97, blue: 1.0),
                panelBackground: Color(.secondarySystemBackground),
                accent: Color(red: 0.15, green: 0.39, blue: 0.92),
                secondaryAccent: Color(red: 0.08, green: 0.50, blue: 0.67)
            )
        }
    }

    private static func theme(for locale: Locale) -> LocaleTheme {
        switch locale.language.languageCode?.identifier {
        case "ar":
            return AppLanguage.arabic.theme
        case "es":
            return AppLanguage.spanish.theme
        case "fr":
            return AppLanguage.french.theme
        default:
            return AppLanguage.english.theme
        }
    }
}

struct LocaleTheme {
    let pageBackground: Color
    let panelBackground: Color
    let accent: Color
    let secondaryAccent: Color
}
