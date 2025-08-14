//
//  MainTabView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 12/08/2025.



import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Favourites")
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favourite")
                }
            
            
            Text("Recycle")
                .tabItem {
                    Image(systemName: "arrow.clockwise")
                    Text("Recycle")
                }
            
            Text("Cart")
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
            
            Text("Profile")
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
    }
}
