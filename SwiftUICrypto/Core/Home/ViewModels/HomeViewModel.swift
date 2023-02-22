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
    @Published var isLoading: Bool = false
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
       
       // Update portfolioData
       self.$allCoins
           .combineLatest(portfolioDataService.$savedEntity)
           .map(mapAllCoinsToPortfolioCoins)
           .sink { [weak self] returnedCoins in
               self?.portfolioCoins = returnedCoins
           }
           .store(in: &cancellables)
       
       // Update marketData
       marketDataService.$marketData
           .combineLatest($portfolioCoins) // Update "Portfolio Value" in HomeStatView
           .map(mapGlobalMarketData)
           .sink { [weak self] returnedStats in
               self?.statistics = returnedStats
               self?.isLoading = false
           }
           .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allCoins.compactMap { coin -> CoinModel? in
            guard let entity = portfolioEntities.first(where: { coin.id == $0.coinID } ) else {
                return nil
            }
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(data: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stat: [StatisticModel] = []
        guard let data = data else { return stat }
        
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue =
            portfolioCoins
            .map { $0.currentHoldingsValue }
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24H ?? 0) / 100
                
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
       
        stat.append(contentsOf: [marketCap,
                                 volume,
                                 btcDominance,
                                 portfolio
                                ])
        
        return stat
    }
}
