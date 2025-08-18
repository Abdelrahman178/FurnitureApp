//
//  AppState.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 14/08/2025.
//

import SwiftUI
import FirebaseAuth

enum AuthIntent { case purchase, upload, generic }

final class AppState: ObservableObject {
    // Onboarding flag — first-launch only
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false

    // Auth state that mirrors Firebase
    @Published var isAuthenticated: Bool

    // Login gate sheet
    @Published var showAuthGate: Bool = false
    @Published var pendingIntent: AuthIntent? = nil

    private var authHandle: AuthStateDidChangeListenerHandle?

    init() {
        print("AppState: Initializing...")
        self.isAuthenticated = Auth.auth().currentUser != nil
        print("AppState: Initial auth state - isAuthenticated: \(self.isAuthenticated)")
        
        // Keep isAuthenticated in sync with Firebase
        authHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async { 
                self?.isAuthenticated = (user != nil)
                print("AppState: Auth state changed - isAuthenticated: \(self?.isAuthenticated ?? false)")
            }
        }
        print("AppState: Initialization complete")
    }

    deinit { 
        if let h = authHandle { 
            Auth.auth().removeStateDidChangeListener(h) 
        } 
    }

    // Ask for auth only when necessary (buy/upload)
    func requireAuth(for intent: AuthIntent = .generic) {
        if Auth.auth().currentUser == nil {
            pendingIntent = intent
            showAuthGate = true
        }
    }

    func didLogin() {
        isAuthenticated = true
        showAuthGate = false
        pendingIntent = nil
    }

    func didSkipLogin() {
        showAuthGate = false
        pendingIntent = nil
    }

    func signOut() {
        do { 
            try Auth.auth().signOut() 
            print("AppState: User signed out successfully")
        } catch { 
            print("AppState: Sign-out error: \(error)") 
        }
        isAuthenticated = false
    }
}


