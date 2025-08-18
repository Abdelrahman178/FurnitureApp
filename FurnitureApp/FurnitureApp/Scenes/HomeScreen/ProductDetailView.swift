//
//  ProductDetailView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 14/08/2025.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @EnvironmentObject var productViewModel: ProductViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var currentImageIndex = 0
    
    // Sample images for the slider
    let productImages = ["chair1", "chair2", "chair3", "chair4"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Image Slider
                    TabView(selection: $currentImageIndex) {
                        ForEach(0..<productImages.count, id: \.self) { index in
                            Image(productImages[index])
                                .resizable()
                                .scaledToFit()
                                .frame(height: 300)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 300)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    
                    VStack(alignment: .leading, spacing: 16) {
                        // Product Name and Price
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(product.name)
                                    .font(.custom("Inter-Bold", size: 24))
                                    .foregroundColor(Color("PrimaryTextColor"))
                                
                                Text("$\(product.price)")
                                    .font(.custom("Inter-SemiBold", size: 20))
                                    .foregroundColor(Color("SplashButtonColor"))
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                productViewModel.toggleFavorite(for: product)
                            }) {
                                Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                                    .foregroundColor(product.isFavorite ? .red : .gray)
                                    .font(.title2)
                                    .padding(12)
                                    .background(Color.gray.opacity(0.1))
                                    .clipShape(Circle())
                            }
                        }
                        
                        // Full Description
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Description")
                                .font(.custom("Inter-Bold", size: 18))
                                .foregroundColor(Color("PrimaryTextColor"))
                            
                            Text(product.description)
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(.gray)
                                .lineSpacing(4)
                        }
                        
                        // Add to Cart Button
                        Button(action: {
                            // Add to cart functionality
                        }) {
                            Text("Add to Cart")
                                .font(.custom("Inter-SemiBold", size: 18))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("SplashButtonColor"))
                                .cornerRadius(12)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                }
            }
            .navigationTitle("Product Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(name: "Modern Chair", price: "12,500", imageName: "chair"))
            .environmentObject(ProductViewModel())
    }
}
