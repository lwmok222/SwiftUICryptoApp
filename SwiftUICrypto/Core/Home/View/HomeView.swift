//
//  HomeView.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-16.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfilo: Bool = false
    
    var body: some View {
        ZStack {
            // Background Layer
            Color.theme.background
                .ignoresSafeArea()
            
            // Content Layer
            VStack {
                homeHeader
                
                Spacer(minLength: 0)
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .toolbar(.hidden)
        }
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfilo ? "plus" : "info")
                .animation(.none, value: showPortfilo)
                .background(
                    CircleButtonAnimationView(animate: $showPortfilo)
                )
            Spacer()
            
            Text(showPortfilo ? "Portfilo" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none, value: showPortfilo)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfilo ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfilo.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
