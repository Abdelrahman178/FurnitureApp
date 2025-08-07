//
//  SplashView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 03/08/2025.


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
