//
//  FavouriteView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 12/08/2025.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    @State private var showingProductDetail = false
    @State private var selectedProduct: Product?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if productViewModel.favoriteProducts.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "heart")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("No Favorites Yet")
                            .font(.custom("Inter-Bold", size: 24))
                            .foregroundColor(Color("PrimaryTextColor"))
                        
                        Text("Start adding products to your favorites by tapping the heart icon on any product")
                            .font(.custom("Inter-Regular", size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 100)
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(productViewModel.favoriteProducts) { product in
                            FavoriteProductCard(product: product) {
                                selectedProduct = product
                                showingProductDetail = true
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showingProductDetail) {
                if let product = selectedProduct {
                    ProductDetailView(product: product)
                        .environmentObject(productViewModel)
                }
            }
        }
    }
}

struct FavoriteProductCard: View {
    let product: Product
    let onTap: () -> Void
    @EnvironmentObject var productViewModel: ProductViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white)
                    .shadow(radius: 1)
                    .frame(height: 180)
                    .overlay(
                        Image(product.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(20)
                    )
                    .onTapGesture {
                        onTap()
                    }

                Button(action: {
                    
                    
                    productViewModel.toggleFavorite(for: product)
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .font(.title2)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(8)
            }

            Text(product.name)
                .font(.custom("Inter-Bold", size: 14))

            Text(product.price)
                .font(.custom("Inter-SemiBold", size: 14))
                .foregroundColor(Color("PrimaryTextColor"))
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
            .environmentObject(ProductViewModel())
    }
}
