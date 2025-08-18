//
//  SplashView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 14/08/2025.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState
    // @EnvironmentObject var authService: AuthService
    @EnvironmentObject var productViewModel: ProductViewModel
    @State private var isActive = false

    var body: some View {
        ZStack {
            // Background image
            Image("SplashImage")
                .resizable()
                .ignoresSafeArea()
            
            // Globe button in top-right corner
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        openAppSettings()
                    }) {
                        Image(systemName: "globe")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding(.top, 50)
                    .padding(.trailing, 20)
                }
                Spacer()
            }
            
            // Debug text to show the app is working
            VStack {
                Spacer()
                Text("Loading...")
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.bottom, 100)
            }
        }
        .statusBarHidden(false)
        .onAppear {
            print("SplashView appeared")
            // Show splash for 2 seconds, then navigate
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                print("SplashView timer completed, navigating...")
                isActive = true
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            print("FullScreenCover triggered, hasSeenOnboarding: \(appState.hasSeenOnboarding)")
            if !appState.hasSeenOnboarding {
                OnboardingView() 
                    .environmentObject(appState)
                    // .environmentObject(authService)
                    .environmentObject(productViewModel)
            } else {
                MainTabView()
                    .environmentObject(appState)
                    // .environmentObject(authService)
                    .environmentObject(productViewModel)
            }
        }
    }
    
    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(AppState())
            // .environmentObject(AuthService())
            .environmentObject(ProductViewModel())
    }
}
