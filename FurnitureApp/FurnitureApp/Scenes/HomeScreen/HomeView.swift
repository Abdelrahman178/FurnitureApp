//
//  HomeView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 10/08/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedCategory = "Chairs"
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
                        Image("profile_pic")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
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
                        ForEach(0..<4) { index in
                            VStack(alignment: .leading, spacing: 8) {
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                        .shadow(radius: 1)
                                        .frame(height: 180)
                                        .overlay(
                                            Image("chair\(index+1)")
                                                .resizable()
                                                .scaledToFit()
                                                .padding(20)
                                        )
                                    
                                    Text("NEW")
                                        .font(.caption2)
                                        .padding(5)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                        .padding(6)
                                }
                                
                                Text("Modern Chair")
                                    .font(.custom("Inter-Bold", size: 14))
                                
                                Text("12,500")
                                    .font(.custom("Inter-SemiBold", size: 14))
                                    .foregroundColor(Color("PrimaryTextColor"))
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
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
