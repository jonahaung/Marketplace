//
//  TabbarView.swift
//  MyBike
//
//  Created by Aung Ko Min on 12/9/21.
//

import SwiftUI

struct TabbarView: View {
    enum Tab: Int {
       case home, messages, profile, settings
   }
    @State private var selectedTab = Tab.home
    
    private var appBackendManager = AppBackendManager.shared
    private var authService = AuthenticationService.shared
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView().tabItem{
                tabbarItem(text: "Home", image: "globe.asia.australia.fill")
            }.tag(Tab.home)
            MessagesView().tabItem {
                tabbarItem(text: "Messages", image: "bubble.left.fill")
            }.tag(Tab.messages)
                .badge("4")
            UserProfileView().tabItem{
                tabbarItem(text: "User", image: "person")
            }.tag(Tab.profile)
            SettingsView().tabItem{
                tabbarItem(text: "Settings", image: "gear")
            }.tag(Tab.settings)
        }
        .environmentObject(authService)
        .environmentObject(appBackendManager)
    }
    
    private func tabbarItem(text: String, image: String) -> some View {
        Image(systemName: image)
            .imageScale(.large)
    }
}

