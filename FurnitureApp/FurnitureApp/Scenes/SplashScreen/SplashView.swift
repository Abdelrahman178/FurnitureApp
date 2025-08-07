//
//  SplashView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 03/08/2025.

//
//import SwiftUI
//
//struct SplashView: View {
//    @State private var showAlert = false
//
//    var body: some View {
//        VStack(spacing: 0) {
//
//            ZStack(alignment: .topTrailing) {
//                Image("SplashImage")
//                    .resizable()
//                    .frame(width: 428, height: 600)
//                    .clipped()
//
//                Button(action: {
//                    toggleLanguage()
//                    showAlert = true
//
//                }) {
//                    Image(systemName: "globe")
//                        .font(.system(size: 20))
//                        .foregroundColor(.white)
//                        .padding(10)
//                        .background(Color.black.opacity(0.5))
//                        .clipShape(Circle())
//                        .padding(.top, 50)
//                        .padding(.trailing, 35)
//                }
//            }
//
//            VStack(alignment: .leading, spacing: 12) {
//                Text(NSLocalizedString("splash_title", comment: ""))
//                    .font(.custom("Inter-Bold", size: 24))
//                    .foregroundColor(.black)
//
//                Text(NSLocalizedString("splash_description", comment: ""))
//                    .font(.custom("Inter-Regular", size: 16))
//                    .foregroundColor(.gray)
//
//                Spacer()
//
//                Button(action: {
//                }) {
//                    Text(NSLocalizedString("get_started", comment: ""))
//                        .font(.custom("Inter-SemiBold", size: 18))
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color("SplashButtonColor"))
//                        .cornerRadius(40)
//                }
//            }
//            .padding()
//            .background(Color.white)
//
//            Spacer()
//        }
//        .edgesIgnoringSafeArea(.all)
//        .alert(isPresented: $showAlert) {
//
//
//            Alert(
//                title: Text(NSLocalizedString("language_alert_title", comment: "")),
//                dismissButton: .default(Text(NSLocalizedString("ok", comment: "")))
//            )
//        }
//    }
//
//
//    func toggleLanguage() {
//        let current = Locale.current.language.languageCode?.identifier ?? "en"
//        let newLang = current == "en" ? "ar" : "en"
//        UserDefaults.standard.set([newLang], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//    }
//}
//



// SplashView.swift

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            
            ZStack(alignment: .topTrailing) {
                Image("SplashImage")
                    .resizable()
                    .frame(width: 428, height: 600)
                    .clipped()
                
                Button(action: {
                    openAppSettings()
                }) {
                    Image(systemName: "globe")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black.opacity(0.4))
                        .clipShape(Circle())
                        .padding(.top, 50)
                        .padding(.trailing, 35)
                }
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(LanguageManager.shared.localizedString(for: "splash_title"))
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(.black)
                
                Text(LanguageManager.shared.localizedString(for: "splash_description"))
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(.gray)
                Spacer()
                
                Button(action: {
                    
                }) {
                    Text(LanguageManager.shared.localizedString(for: "get_started"))
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
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
