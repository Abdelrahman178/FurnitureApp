//
//  LoginView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 07/08/2025.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authService: AuthService
    
    @State private var email = ""
    @State private var password = ""
    @State private var goToSignUp = false
    @State private var goToHome = false
    @State private var errorMessage = ""

    var body: some View {
        
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // Skip button in top-right
                HStack {
                    Spacer()
                    Button(action: {
                        goToHome = true
                    }) {
                        Text("Skip")
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundColor(Color("SplashButtonColor"))
                    }
                }
                .padding(.bottom, 20)

                Text(LanguageManager.shared.localizedString(for: "login_welcome_title"))
                    .font(.custom("Inter-Bold", size: 24))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryTextColor"))

                Text(LanguageManager.shared.localizedString(for: "login_welcome_subtitle"))
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color("PrimaryTextColor"))
                    .padding(.bottom, 40)

                VStack(spacing: 16) {
                    TextField(LanguageManager.shared.localizedString(for: "login_email"), text: $email)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                    SecureField(LanguageManager.shared.localizedString(for: "login_password"), text: $password)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                }
                .padding(.bottom, 30)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.custom("Inter-Regular", size: 14))
                }

                Button(action: {
                    login()
                }) {
                    HStack {
                        if authService.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        }
                        
                        Text(LanguageManager.shared.localizedString(for: "login_button"))
                            .font(.custom("Inter-SemiBold", size: 18))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("SplashButtonColor"))
                    .cornerRadius(40)
                }
                .disabled(authService.isLoading)
                .padding(.bottom, 25)

                HStack {
                    Text(LanguageManager.shared.localizedString(for: "login_or_continue_with"))
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)

                VStack(spacing: 16) {
                    Button(action: {
                        Task {
                            await authService.signInWithGoogle()
                            if authService.isAuthenticated {
                                appState.didLogin()
                                goToHome = true
                            }
                        }
                    }) {
                        HStack(spacing: 12) {
                            if authService.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color("PrimaryTextColor")))
                                    .scaleEffect(0.8)
                            } else {
                                Image("google_logo")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }

                            Text("Sign In With Google Account")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color("PrimaryTextColor"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                        )
                    }
                    .disabled(authService.isLoading)

                    Button(action: {
                        // Apple Sign In implementation
                    }) {
                        HStack(spacing: 12) {
                            Image("apple_logo")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color.primary)
                                .frame(width: 24, height: 24)

                            Text("Sign in With Apple Account")
                                .font(.custom("Inter-Bold", size: 16))
                                .foregroundColor(Color("PrimaryTextColor"))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.9), lineWidth: 1)
                        )
                    }
                    .disabled(authService.isLoading)
                }

                Spacer()

                HStack {
                    Spacer()
                    Text(LanguageManager.shared.localizedString(for: "login_no_account"))
                        .font(.custom("Inter-Regular", size: 16))

                    Button(action: {
                        goToSignUp = true
                    }) {
                        Text(LanguageManager.shared.localizedString(for: "login_sign_up"))
                            .font(.custom("Inter-Bold", size: 16))
                            .foregroundColor(Color("SplashButtonColor"))
                    }
                    Spacer()
                }
                .padding(.bottom, 25)

            }
            .padding()
            .navigationDestination(isPresented: $goToHome) {
                MainTabView()
                    .environmentObject(appState)
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goToSignUp) {
                SignUpView()
                    .environmentObject(appState)
            }
            .alert("Authentication Error", isPresented: .constant(authService.errorMessage != nil)) {
                Button("OK") {
                    authService.clearError()
                }
            } message: {
                if let errorMessage = authService.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }

    private func login() {
        if email.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                       options: .regularExpression) == nil {
            errorMessage = "Please enter a valid email address"
            return
        }

        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter both email and password"
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                errorMessage = "Login failed. Please try again."
            } else {
                errorMessage = ""
                appState.didLogin()
                goToHome = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AppState())
            .environmentObject(AuthService())
    }
}





