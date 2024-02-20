//
//  Route.swift
//  NavigationStackWithAction
//
//  Created by MARIJAN VUKCEVICH on 2/19/24.
//

import Foundation

private enum RouteType: Int {
    case login       = 0
    case onBoarding  = 1
    case detail      = 2
    case tabview     = 3
}

enum Route: Hashable {
    case login
    case onBoarding
    case detail(Product)
    case tabview(TabItem)
    
    public static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int {
        get {
            switch self {
            case .login:
                return RouteType.login.hashValue
            case .onBoarding:
                return RouteType.onBoarding.hashValue
            case .detail(_):
                return RouteType.detail.hashValue
            case .tabview(_):
                return RouteType.tabview.hashValue
            }
        }
    }
}

extension Route: Identifiable {
    var id: UUID {
        return UUID()
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}


extension String {
    func isEmptyOrWhiteSpace() -> Bool {
        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
}
