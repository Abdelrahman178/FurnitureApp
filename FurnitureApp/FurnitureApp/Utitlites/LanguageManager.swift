//
//  LanguageManager.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 05/08/2025.
//
//
//import SwiftUI
//import Foundation
//
//struct LanguageManger {
//    enum SupportedLanguage: String {
//        case english = "en"
//        case arabic = "ar"
//        
//        var locale: Locale {
//            return Locale(identifier: self.rawValue)
//        }
//        
//        var layoutDirection: LayoutDirection {
//            return self == .english ? .leftToRight : .rightToLeft
//        }
//    }
//    
//}


import Foundation
import SwiftUI

class LanguageManager {
    
    static let shared = LanguageManager()
    
    private init() {}
    
    var currentLanguage: String {
        return Locale.current.language.languageCode?.identifier ?? "en"
    }
    
    var layoutDirection: LayoutDirection {
        return currentLanguage == "ar" ? .rightToLeft : .leftToRight
    }
    
    func localizedString(for key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
