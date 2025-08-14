////
////  AppState.swift
////  FurnitureApp
////
////  Created by Abdelrahman Amer on 14/08/2025.
////
//
//import SwiftUI
//import FirebaseAuth
//
//enum AuthIntent { case purchase, upload, generic }
//
//final class AppState: ObservableObject {
//    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
//    @Published var isAuthenticated: Bool = Auth.auth().currentUser != nil
//    @Published var showAuthGate: Bool = false
//    @Published var pendingIntent: AuthIntent? = nil
//
//    func requireAuth(for intent: AuthIntent = .generic) {
//        if Auth.auth().currentUser == nil {
//            pendingIntent = intent
//            showAuthGate = true
//        }
//    }
//
//    func didLogin() {
//        isAuthenticated = true
//        showAuthGate = false
//        pendingIntent = nil
//    }
//
//    func didSkipLogin() {
//        showAuthGate = false
//        pendingIntent = nil
//    }
//}
