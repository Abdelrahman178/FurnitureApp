//
//  SignUpView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 09/08/2025.
//
//
import SwiftUI
import FirebaseAuth

struct SignUpView: View {

    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    @State private var goToLogin = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {

                Text(LanguageManager.shared.localizedString(for: "signup_welcome_title"))
                    .font(.custom("Inter-Bold", size: 24))
                    .padding(.bottom, 8)
                    .foregroundColor(Color("PrimaryTextColor"))

                Text(LanguageManager.shared.localizedString(for: "signup_welcome_subtitle"))
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color("PrimaryTextColor"))
                    .padding(.bottom, 40)

                VStack(spacing: 16) {
                    TextField(LanguageManager.shared.localizedString(for: "signup_name"), text: $name)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)

                    TextField(LanguageManager.shared.localizedString(for: "signup_phone"), text: $phone)
                        .keyboardType(.phonePad)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)

                    TextField(LanguageManager.shared.localizedString(for: "signup_email"), text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)

                    SecureField(LanguageManager.shared.localizedString(for: "signup_password"), text: $password)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)

                    SecureField(LanguageManager.shared.localizedString(for: "signup_confirm_password"), text: $confirmPassword)
                        .font(.custom("Inter-Regular", size: 16))
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                }
                .padding(.bottom, 30)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)

                }

                Button(action: {
                    signUp()
                }) {

                    Text(LanguageManager.shared.localizedString(for: "signup_button"))
                        .font(.custom("Inter-SemiBold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("SplashButtonColor"))
                        .cornerRadius(40)
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $goToLogin) {
                LoginView()
            }
        }
    }

    private func signUp() {
        
        if email.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .regularExpression) == nil {
            errorMessage = "Please enter a valid email address"
            return
        }

            if name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill all fields"
            return
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = ""
                goToLogin = true
            }
        }
    }
}




struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
