//
//  HomeViewModel.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-17.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
   private func addSubscribers() {
       // Update allCoins
       $searchText
           .combineLatest(coinDataService.$allCoins) // Will publish either searchText or allCoins changes value
           .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
           .map(filterCoins)
           .sink { [weak self] returnedCoins in
               self?.allCoins = returnedCoins
           }
           .store(in: &cancellables)
       
       // Update marketData
       marketDataService.$marketData
           .map(mapGlobalMarketData)
           .sink { [weak self] returnedStats in
               self?.statistics = returnedStats
           }
           .store(in: &cancellables)
       
       // Update portfolioData
       self.$allCoins
           .combineLatest(portfolioDataService.$savedEntity)
           .map { (coinModels, portfolioEntities) -> [CoinModel] in
               coinModels.compactMap { coin -> CoinModel? in
                   guard let entity = portfolioEntities.first(where: { coin.id == $0.coinID } ) else {
                       return nil
                   }
                   return coin.updateHoldings(amount: entity.amount)
               }
           }
           .sink { [weak self] returnedCoins in
               self?.portfolioCoins = returnedCoins
           }
           .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
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
    
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var stat: [StatisticModel] = []
        guard let data = data else { return stat }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0.0)
        
        stat.append(contentsOf: [marketCap,
                                 volume,
                                 btcDominance,
                                 portfolio
                                ])
        
        return stat
    }
}
