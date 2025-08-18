//
//  ProductViewModel.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 14/08/2025.
//

import SwiftUI
import Foundation

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    
    private let favoritesKey = "favoriteProducts"
    
    init() {
        print("ProductViewModel: Initializing...")
        loadProducts()
        loadFavorites()
        print("ProductViewModel: Initialization complete")
    }
    
    var favoriteProducts: [Product] {
        products.filter { $0.isFavorite }
    }
    
    func toggleFavorite(for product: Product) {
        if let index = products.firstIndex(of: product) {
            products[index].isFavorite.toggle()
            saveFavorites()
        }
    }
    
    private func loadProducts() {
        products = [
            Product(name: "Modern Chair", price: "12,500", imageName: "chair1"),
            Product(name: "Comfortable Chair", price: "14,222", imageName: "chair2"),
            Product(name: "Dining Chair", price: "10,999", imageName: "chair3"),
            Product(name: "Office Chair", price: "8,500", imageName: "chair4"),
            Product(name: "Accent Chair", price: "6,200", imageName: "chair1"),
            Product(name: "Lounge Chair", price: "9,800", imageName: "chair2"),
            Product(name: "Study Chair", price: "7,300", imageName: "chair3"),
            Product(name: "Living Room Chair", price: "11,400", imageName: "chair4")
        ]
        print("ProductViewModel: Loaded \(products.count) products")
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: favoritesKey),
           let favoriteIds = try? JSONDecoder().decode([String].self, from: data) {
            for (index, product) in products.enumerated() {
                if favoriteIds.contains(product.id.uuidString) {
                    products[index].isFavorite = true
                }
            }
            print("ProductViewModel: Loaded \(favoriteIds.count) favorites")
        }
    }
    
    private func saveFavorites() {
        let favoriteIds = products.filter { $0.isFavorite }.map { $0.id.uuidString }
        if let data = try? JSONEncoder().encode(favoriteIds) {
            UserDefaults.standard.set(data, forKey: favoritesKey)
            print("ProductViewModel: Saved \(favoriteIds.count) favorites")
        }
    }
}
