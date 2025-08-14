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

    var test2: Int{
        return 1+2
    }

    var test: Int = 10

    @State private var email = ""
    @State private var password = ""

    @State private var goToSignUp = false

    @State private var goToHome = false

    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {

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


              ///
                ///
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
              ///
                ///

                Button(action: {
                    login()
                }) {
                    Text(LanguageManager.shared.localizedString(for: "login_button"))
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("SplashButtonColor"))
                        .cornerRadius(40)
                }
                .padding(.bottom, 25)

                HStack {
                    Text(LanguageManager.shared.localizedString(for: "login_or_continue_with"))
                        .font(.custom("Inter-Regular", size: 14))
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)

                VStack(spacing: 16) {
                    Button(action: {


                    }) {
                        HStack(spacing: 12) {
                            Image("google_logo")
                                .resizable()
                                .frame(width: 24, height: 24)

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

                    Button(action: {

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
                MainTabView() // 3aizen nbos 3leha
                    .navigationBarBackButtonHidden(true)
            }
            .navigationDestination(isPresented: $goToSignUp) {
                SignUpView()
            }

//            .onAppear {
//                if Auth.auth().currentUser != nil {
//                    goToHome = true
//                }
//            }

        }
    }



    private func login() {
        // el /. 3lashanel . bs m3naha any character
        //bs el /. 3lshan yshof eldot bs

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
                goToHome = true
            }
        }
    }

}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}





