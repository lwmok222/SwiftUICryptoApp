//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-16.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    init() {
        // Override Navigation bar title color
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    //.navigationBarHidden(true)
                    .toolbar(.hidden)
            }
            .environmentObject(vm)
        }
    }
}
