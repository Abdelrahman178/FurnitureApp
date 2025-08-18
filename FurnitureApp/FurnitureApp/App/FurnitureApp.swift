//
//  FurnitureApp.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 03/08/2025.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

@main
struct FurnitureApp: App {
    @StateObject private var appState = AppState()
    // @StateObject private var authService = AuthService()
    @StateObject private var productViewModel = ProductViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(appState)
                // .environmentObject(authService)
                .environmentObject(productViewModel)
                .environment(\.layoutDirection, LanguageManager.shared.layoutDirection)
                .onOpenURL { url in
                    // Handle Google Sign-In redirect
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}

