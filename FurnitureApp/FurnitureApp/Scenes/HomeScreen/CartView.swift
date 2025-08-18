//
//  CartView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 12/08/2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "cart")
                        .font(.system(size: 80))
                        .foregroundColor(.gray)
                    
                    Text("Your Cart is Empty")
                        .font(.custom("Inter-Bold", size: 24))
                        .foregroundColor(Color("PrimaryTextColor"))
                    
                    Text("Add items to your cart to see them here")
                        .font(.custom("Inter-Regular", size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        // Navigate to home to add items
                    }) {
                        Text("Start Shopping")
                            .font(.custom("Inter-SemiBold", size: 18))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("SplashButtonColor"))
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                }
                .padding(.top, 100)
            }
            .navigationTitle("Cart")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(ProductViewModel())
    }
}
