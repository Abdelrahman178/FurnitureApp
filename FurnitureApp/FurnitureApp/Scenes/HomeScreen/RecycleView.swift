//
//  RecycleView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 14/08/2025.
//

import SwiftUI

struct RecycleView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "arrow.clockwise.circle")
                    .font(.system(size: 80))
                    .foregroundColor(Color("SplashButtonColor"))
                
                Text("Recycle")
                    .font(.custom("Inter-Bold", size: 24))
                    .foregroundColor(Color("PrimaryTextColor"))
                
                Text("Recycled products will appear here")
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Recycle")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct RecycleView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleView()
    }
}
