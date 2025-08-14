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
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environment(\.layoutDirection, LanguageManager.shared.layoutDirection)
                .onOpenURL { url in
                    // This handles the redirect from Google
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
    
