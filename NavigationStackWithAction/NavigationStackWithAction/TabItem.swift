//
//  TabItem.swift
//  NavigationActionAzam
//
//  Created by MARIJAN VUKCEVICH on 2/19/24.
//

import Foundation

enum TabItem: String, CaseIterable {
    case home
    case news
    case settings
    case weather
    
    var description: String {
        switch self {
        case .home:
            return "Home"
        case .news:
            return "News"
        case .settings:
            return "Settings"
        case .weather:
            return "Waether"
        }
    }
    
    var icon: String {
        switch self {
        case .home:
            return "house.circle.fill"
            
        case .news:
            return "newspaper.circle.fill"
            
        case .settings:
            return "gearshape.circle.fill"
            
        case .weather:
            return "sun.max.circle"
        }
    }
}
