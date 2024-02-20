//
//  ContentView.swift
//  NavigationStackWithAction
//
//  Created by MARIJAN VUKCEVICH on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            LoginScreen()
        }
        .padding()
    }
}

struct LoginFormConfig {
    var username: String = ""
    var password: String = ""
    var isFormValid: Bool {
        !username.isEmptyOrWhiteSpace() && !password.isEmptyOrWhiteSpace()
    }
}

struct LoginScreen: View {
    @Environment(\.navigate) private var navigate
    @State private var loginFormConfig: LoginFormConfig = LoginFormConfig()
    @FocusState private var textfieldFocused: Bool
    
    var body: some View {
        Form {
            Section(header: Text("Login")) {
                TextField("Username", text: $loginFormConfig.username)
                    .focused($textfieldFocused)
                    .autocorrectionDisabled()
                    .frame(height:28)
                    .frame(maxWidth: .infinity, maxHeight: 28)
                    .padding()
                TextField("Password", text: $loginFormConfig.password)
                    .focused($textfieldFocused)
                    .autocorrectionDisabled()
                    .frame(height:28)
                    .frame(maxWidth: .infinity, maxHeight: 28)
                    .padding()
            }
            .foregroundColor(.green)
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .formStyle(.grouped)
        .background(Color.gray.opacity(0.7))
        .font(.system(size: 20))
        
        Button {
            navigate(.push(.onBoarding))
        } label: {
            Text("Login")
                .frame(height: 35)
                .frame(maxWidth: .infinity, maxHeight: 35, alignment: .center)
                .font(.system(size: 22, weight: .bold, design: .default))
        }
        .foregroundColor(.white)
        .background(Color.blue.opacity(0.5))
        .cornerRadius(12)
        .padding(.top, 20)
        .padding([.leading, .trailing], 20)
        
        Text("Thanks for Azam Sharp and his very nice article.")
            .font(.system(size: 17))
            .padding()
            .foregroundColor(.blue)
        Text("Here is the link to article:")
            .font(.system(size: 17))
        Link("Build large scale apps - Navigation", destination: URL(string: "https://azamsharp.com/2023/02/28/building-large-scale-apps-swiftui.html#navigation")!)
            .font(.system(size: 17))
            .foregroundStyle(.cyan)
        Spacer()
    }
}

struct OnBoardingView: View {
    @Environment(\.navigate) private var navigate
    let product = Product(productId: 0, name: "chair", category: nil, price: 40.0, description: "sitting chair", reviews: [])
    var body: some View {
        VStack(spacing: 20) {
            Text("OnBoarding")
                .font(.title)
                .padding()
            Button("Go to Product") {
                Task {
                    navigate(.push(.detail(product)))
                }
            }
            .padding()
            Button("Go to TabView - Weather") {
                Task {
                    navigate(.push(.tabview(.weather)))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        Spacer()
    }
}

struct ProductView: View {
    let product: Product
    @Environment(\.dismiss) private var dismiss
    @Environment(\.navigate) private var navigate

    var body: some View {
        VStack {
            Group {
                Text("ProductView")
                    .font(.title)
                    .padding()
                Text("ProductView \(product.name ?? "")")
                    .font(.system(size: 18))
                    .padding()
                Button("Go to Tab - Home") {
                    navigate(.push(.tabview(.home)))
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

//MARK: - TabView and their views
struct MainTabView: View {
    @State var selectedTab = TabItem.home
    var tabItems = TabItem.allCases
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                HomePage(tabSelection: $selectedTab)
                    .tag(tabItems[0])
                    .ignoresSafeArea(.all)
                    .tabItem {
                        Label(TabItem.home.description, systemImage: "\(TabItem.home.icon)")
                    }
                
                NewsView(tabSelection: $selectedTab)
                    .tag(tabItems[1])
                    .ignoresSafeArea(.all)
                    .tabItem {
                        Label(TabItem.news.description, systemImage: "\(TabItem.news.icon)")
                    }
                
                SettingsView(tabSelection: $selectedTab)
                    .tag(tabItems[2])
                    .ignoresSafeArea(.all)
                    .tabItem {
                        Label(TabItem.settings.description, systemImage: "\(TabItem.settings.icon)")
                    }
                
                WeatherView(tabSelection: $selectedTab)
                    .tag(tabItems[3])
                    .ignoresSafeArea(.all)
                    .tabItem {
                        Label(TabItem.weather.description, systemImage: "\(TabItem.weather.icon)")
                    }
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomePage: View {
    @Binding var tabSelection: TabItem
    var body: some View {
        VStack {
            Text("home page")
                .font(.title)
                .padding()
        }
    }
}

struct NewsView: View {
    @Binding var tabSelection: TabItem
    @Environment(\.navigate) private var navigate
    var body: some View {
        VStack {
            Text("News page")
                .font(.title)
                .padding()
            Button("Go to onBoarding") {
                navigate(.push(.onBoarding))
            }
        }
    }
}

struct SettingsView: View {
    @Binding var tabSelection: TabItem
    @Environment(\.navigate) private var navigate
    var body: some View {
        VStack {
            Text("Settings view")
                .font(.title)
                .padding()
            Button("Go back to login") {
                navigate(.unwind(.login))
            }
        }
    }
}

struct WeatherView: View {
    @Binding var tabSelection: TabItem
    var body: some View {
        VStack {
            Text("Weather View")
                .font(.title)
                .padding()
            
            NavigationLink {
                WaetherListView()
            } label: {
                Text("Go to weather link")
                    .font(.system(size: 18))
                    .foregroundColor(Color.blue)
            }
        }
    }
}

struct WaetherListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.navigate) private var navigate
    var body: some View {
        VStack {
            Text("Weather list view")
                .font(.title)
                .padding()
            Button("Go back to login") {
                navigate(.unwind(.login))
            }
            .padding(.bottom, 20)
            Button("Go to onBoarding") {
                navigate(.push(.onBoarding))
            }
            .padding(.bottom, 20)
            Button("Go to Tab View - Settings") {
                navigate(.push(.tabview(.settings)))
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
