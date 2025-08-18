
//  HomeView.swift
//  FurnitureApp

//  Created by Abdelrahman Amer on 10/08/2025.


import SwiftUI

struct HomeView: View {
    @EnvironmentObject var productViewModel: ProductViewModel
    @State private var selectedCategory = "Chairs"
    @State private var showingProductDetail = false
    @State private var selectedProduct: Product?
    
    let categories = ["Chairs", "Cupboard", "Tables", "Sofas"]

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Discover The Best")
                                .font(.custom("Inter-Bold", size: 22))
                                .foregroundColor(Color("PrimaryTextColor"))

                            Text("Furniture.")
                                .font(.custom("Inter-Bold", size: 22))
                                .foregroundColor(Color("PrimaryTextColor"))
                        }
                        Spacer()
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("SplashButtonColor"))
                    }
                    .padding(.horizontal)

                    HStack {
                        TextField("Search for furniture", text: .constant(""))
                            .padding(12)
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .padding(.trailing, 10)
                    }
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .font(.custom("Inter-Regular", size: 14))
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(selectedCategory == category ? Color("SplashButtonColor") : Color.gray.opacity(0.15))
                                        .foregroundColor(selectedCategory == category ? .white : .black)
                                        .cornerRadius(20)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(productViewModel.products) { product in
                            ProductCard(product: product) {
                                selectedProduct = product
                                showingProductDetail = true
                            }
                        }
                    }
                    .padding(.horizontal)

                    Text("Best Seller")
                        .font(.custom("Inter-Bold", size: 18))
                        .foregroundColor(Color("PrimaryTextColor"))
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<3) { index in
                                VStack(alignment: .leading, spacing: 8) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(radius: 1)
                                        .frame(width: 160, height: 160)
                                        .overlay(
                                            Image("chair\(index+1)")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(20)
                                        )

                                    Text("Yellow Chair")
                                        .font(.custom("Inter-Bold", size: 14))
                                    Text("10,500")
                                        .font(.custom("Inter-SemiBold", size: 14))
                                        .foregroundColor(Color("PrimaryTextColor"))
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemGray6))
            .sheet(isPresented: $showingProductDetail) {
                if let product = selectedProduct {
                    ProductDetailView(product: product)
                        .environmentObject(productViewModel)
                }
            }
        }
    }
}

struct ProductCard: View {
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
                    Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(product.isFavorite ? .red : .gray)
                        .font(.title2)
                        .padding(8)
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                }
                .padding(8)

                Text("NEW")
                    .font(.caption2)
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(6)
                    .offset(x: 50, y: 0)
            }

            Text(product.name)
                .font(.custom("Inter-Bold", size: 14))

            Text(product.price)
                .font(.custom("Inter-SemiBold", size: 14))
                .foregroundColor(Color("PrimaryTextColor"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ProductViewModel())
    }
}
