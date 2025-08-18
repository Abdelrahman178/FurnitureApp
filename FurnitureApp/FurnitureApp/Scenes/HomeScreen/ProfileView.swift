//
//  ProfileView.swift
//  FurnitureApp
//
//  Created by Abdelrahman Amer on 12/08/2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var authService: AuthService
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    // Profile Header
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color("SplashButtonColor"))
                            .overlay(
                                Circle()
                                    .stroke(Color("SplashButtonColor"), lineWidth: 3)
                            )
                        
                        VStack(spacing: 8) {
                            Text(authService.currentUser?.displayName ?? "User")
                                .font(.custom("Inter-Bold", size: 24))
                                .foregroundColor(Color("PrimaryTextColor"))
                            
                            Text(authService.currentUser?.email ?? "user@example.com")
                                .font(.custom("Inter-Regular", size: 16))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.top, 20)
                    
                    // Profile Options
                    VStack(spacing: 0) {
                        ProfileOptionRow(icon: "person", title: "Edit Profile", action: {})
                        ProfileOptionRow(icon: "bell", title: "Notifications", action: {})
                        ProfileOptionRow(icon: "shield", title: "Privacy", action: {})
                        ProfileOptionRow(icon: "questionmark.circle", title: "Help & Support", action: {})
                        ProfileOptionRow(icon: "info.circle", title: "About", action: {})
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 1)
                    .padding(.horizontal)
                    
                    // Logout Button
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        HStack {
                            if authService.isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                    .scaleEffect(0.8)
                            } else {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .foregroundColor(.red)
                            }
                            
                            Text("Logout")
                                .font(.custom("Inter-SemiBold", size: 16))
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .disabled(authService.isLoading)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .alert("Logout", isPresented: $showingLogoutAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Logout", role: .destructive) {
                    Task {
                        await authService.signOut()
                        appState.signOut()
                    }
                }
            } message: {
                Text("Are you sure you want to logout?")
            }
            .alert("Error", isPresented: .constant(authService.errorMessage != nil)) {
                Button("OK") {
                    authService.clearError()
                }
            } message: {
                if let errorMessage = authService.errorMessage {
                    Text(errorMessage)
                }
            }
        }
    }
}

struct ProfileOptionRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color("SplashButtonColor"))
                    .frame(width: 24)
                
                Text(title)
                    .font(.custom("Inter-Regular", size: 16))
                    .foregroundColor(Color("PrimaryTextColor"))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
        
        if title != "About" {
            Divider()
                .padding(.leading, 56)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppState())
            .environmentObject(AuthService())
    }
}
