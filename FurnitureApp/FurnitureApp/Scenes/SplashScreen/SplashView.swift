//
//  SplashView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 03/08/2025.


import SwiftUI

struct SplashView: View {
    
    var body: some View {
        
        VStack() {
            Image("SplashImage")
                .resizable()
                .frame( width: 428, height: 600)
                .clipped()

            VStack(alignment: .leading, spacing: 2) {
                Text("Enjoy Your Furniture Renew")
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(.black)
                
                Text("")
                
                Text("Browse through all categories and discover furniture ready for a second life in your dream home")
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(.gray)


                Spacer()
                
                Button(action: {

                }) {
                    Text("Get Started")
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
}
