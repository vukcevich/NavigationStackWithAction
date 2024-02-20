//
//  NavigationStackWithActionApp.swift
//  NavigationStackWithAction
//
//  Created by MARIJAN VUKCEVICH on 2/19/24.
//

////https://azamsharp.com/2023/02/28/building-large-scale-apps-swiftui.html#navigation

import SwiftUI

@main
struct NavigationStackWithActionApp: App {
    @State private var routes: [Route] = []
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $routes) {
                ContentView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            LoginScreen()
                                .padding()
                        case .onBoarding:
                            OnBoardingView()
                                .padding()
                        case .detail(let product):
                            ProductView(product: product)
                        case .tabview(let tabItem):
                            MainTabView(selectedTab: tabItem)
                        }
                    }
            }
            .onNavigate { navType in
                switch navType {
                case .push(let route):
                    routes.append(route)
                case .unwind(let route):
                    if route == .login {
                        routes = []
                    } else {
                        guard let index = routes.firstIndex(where: { $0 == route })  else { return }
                        routes = Array(routes.prefix(upTo: index + 1))
                    }
                }
            }
        }
    }
}
