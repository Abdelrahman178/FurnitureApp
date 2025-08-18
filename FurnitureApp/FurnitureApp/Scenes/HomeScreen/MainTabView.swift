//
//  MainTabView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 12/08/2025.

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var productViewModel: ProductViewModel
    // @EnvironmentObject var authService: AuthService
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            FavouriteView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
            
            RecycleView()
                .tabItem {
                    Image(systemName: "arrow.clockwise")
                    Text("Recycle")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(Color("SplashButtonColor"))
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AppState())
            // .environmentObject(AuthService())
            .environmentObject(ProductViewModel())
    }
}
