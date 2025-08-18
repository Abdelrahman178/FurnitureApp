//
//  OnboardingView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 03/08/2025.

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var productViewModel: ProductViewModel
    @State private var goToLogin = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Image with top-right globe button
            ZStack(alignment: .topTrailing) {
                Image("SplashImage")
                    .resizable()
                    .frame(width: 428, height: 600)
                    .clipped()

                Button(action: {
                    openAppSettings()
                }) {
                    Image(systemName: "globe")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Circle())
                        .padding(.top, 50)
                        .padding(.trailing, 20)
                }
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(NSLocalizedString("splash_title", comment: ""))
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(.black)

                Text(NSLocalizedString("splash_description", comment: ""))
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(.gray)

                Spacer()

                Button(action: {
                    print("OnboardingView: Get Started button tapped")
                    appState.hasSeenOnboarding = true
                    goToLogin = true
                }) {
                    Text(NSLocalizedString("get_started", comment: ""))
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("SplashButtonColor"))
                        .cornerRadius(40)
                }
            }
            .padding()
            .background(Color.white)

            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $goToLogin) {
            print("OnboardingView: Navigating to LoginView")
            LoginView()
                .environmentObject(appState)
                .environmentObject(authService)
                .environmentObject(productViewModel)
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

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(AppState())
            .environmentObject(AuthService())
            .environmentObject(ProductViewModel())
    }
}
