//
//  DetailView.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-22.
//

import SwiftUI

struct CoinDetailLoadingView: View {
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
               CoinDetailView(coin: coin)
            }
        }
    }
}

struct CoinDetailView: View {
    @StateObject var vm: CoinDetailViewModel
    
    init(coin: CoinModel) {
       _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("Initializing DetailView for \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: dev.coin)
    }
}
