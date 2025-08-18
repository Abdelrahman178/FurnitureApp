//
//  Product.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 14/08/2025.
//

import Foundation

struct Product: Identifiable, Equatable, Codable {
    var id = UUID()
    let name: String
    let price: String
    let imageName: String
    var isFavorite: Bool = false
    
    var description: String {
        return "This beautiful \(name.lowercased()) is crafted with premium materials and designed for both comfort and style. Perfect for any modern home, it combines elegant aesthetics with practical functionality. The \(name.lowercased()) features ergonomic design principles and is built to last, making it an excellent investment for your living space."
    }
}
