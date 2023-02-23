//
//  DetailViewModel.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-23.
//

import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailDataService.$coinDetails
            .sink { returnCoinDetails in
                print("Received Coin Details")
                print("\(returnCoinDetails)")
            }
            .store(in: &cancellables)
    }
}
