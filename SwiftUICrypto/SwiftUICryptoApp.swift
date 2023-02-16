//
//  SwiftUICryptoApp.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-16.
//

import SwiftUI

@main
struct SwiftUICryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    //.navigationBarHidden(true)
                    .toolbar(.hidden)
            }
        }
    }
}
