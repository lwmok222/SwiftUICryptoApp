//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-17.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Title1", value: "Value1", percentageChange: 1),
        StatisticModel(title: "Title1", value: "Value1"),
        StatisticModel(title: "Title1", value: "Value1"),
        StatisticModel(title: "Title1", value: "Value1", percentageChange: -1),
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
   private func addSubscribers() {
       // Update allCoins
       $searchText
           .combineLatest(dataService.$allCoins) // Will publish either searchText or allCoins changes value
           .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
           .map(filterCoins)
           .sink { [weak self] returnedCoins in
               self?.allCoins = returnedCoins
           }
           .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
