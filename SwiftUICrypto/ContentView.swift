//
//  ContentView.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("accent Color")
                    .foregroundColor(Color.theme.accent)
                
                Text("Secondary text color")
                    .foregroundColor(Color.theme.secondaryText)
                
                Text("Red Color")
                    .foregroundColor(Color.theme.red)
                
                Text("Green Color")
                    .foregroundColor(Color.theme.green)
                
            }
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
