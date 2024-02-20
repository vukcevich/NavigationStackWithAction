//
//  Product.swift
//  NavigationStackWithAction
//
//  Created by MARIJAN VUKCEVICH on 2/19/24.
//

import Foundation

struct Product: Codable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.productId == rhs.productId
    }
    public func hash(into hasher: inout Hasher) {
         return hasher.combine(productId)
    }
    
    let productId: Int?
    let name: String?
    let category: Category?
    let price: Double?
    let description: String?
    let reviews: [Review]?
}
struct Category: Codable {
    
}
struct Review: Codable {
    
}
