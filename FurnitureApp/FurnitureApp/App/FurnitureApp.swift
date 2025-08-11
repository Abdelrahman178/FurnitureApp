//
//  FurnitureApp.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 03/08/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct FurnitureApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.layoutDirection, LanguageManager.shared.layoutDirection)
        }
    }
}
