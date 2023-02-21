//
//  MarketDataModel.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-21.
//

import Foundation

// JSON Data
/*
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 "data": {
     "active_cryptocurrencies": 12297,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 666,
     "total_market_cap": {
       "btc": 47494829.2108987,
       "eth": 697375095.5177395,
       "ltc": 12481464187.27286,
       "bch": 7966221000.71398,
       "bnb": 3726907257.1966405,
       "eos": 960433199116.1686,
       "xrp": 3001936970220.8076,
       "xlm": 12291568149866.23,
       "link": 150776899989.42233,
       "dot": 160254864226.34952,
       "yfi": 156915511.61238992,
       "usd": 1165937931993.2668,
       "aed": 4282431727314.665,
       "ars": 225259674836271.7,
       "aud": 1693758033806.615,
       "bdt": 123909763404039.1,
       "bhd": 439404696554.43805,
       "bmd": 1165937931993.2668,
       "brl": 6025683826334.391,
       "cad": 1574180605439.3174,
       "chf": 1079800769453.4657,
       "clp": 931561088903979.9,
       "cny": 8014540750728.508,
       "czk": 25907107036690.31,
       "dkk": 8129912640975.111,
       "eur": 1092064104622.1699,
       "gbp": 961453405604.4242,
       "hkd": 9146724779590.562,
       "huf": 417690174068022.9,
       "idr": 17743904423950886,
       "ils": 4238837308037.4346,
       "inr": 96622856270179.72,
       "jpy": 157186796755121.03,
       "krw": 1518649314780282.8,
       "kwd": 357391456480.09955,
       "lkr": 422371727336341.44,
       "mmk": 2450094381200650,
       "mxn": 21456825718747.99,
       "myr": 5168019883560.152,
       "ngn": 536879439544937.7,
       "nok": 11976106359158.639,
       "nzd": 1872496318781.1843,
       "php": 64127758027251.2,
       "pkr": 305976927095744,
       "pln": 5184134311718.232,
       "rub": 87503635966404.7,
       "sar": 4373209322823.7964,
       "sek": 12038404754740.883,
       "sgd": 1560249979027.865,
       "thb": 40324254862470.086,
       "try": 22004863184302.113,
       "twd": 35529743195423.984,
       "uah": 42880516647406.625,
       "vef": 116745365130.48552,
       "vnd": 27655088290726336,
       "zar": 21280745772258.363,
       "xdr": 876547473520.8077,
       "xag": 53179688291.17961,
       "xau": 634281894.3836583,
       "bits": 47494829210898.695,
       "sats": 4749482921089870
     },
     "total_volume": {
       "btc": 3355991.6099966364,
       "eth": 49276626.707841404,
       "ltc": 881942093.2531574,
       "bch": 562894346.3100255,
       "bnb": 263343814.35184523,
       "eos": 67864350956.68178,
       "xrp": 212117307361.28113,
       "xlm": 868524011350.4222,
       "link": 10653917905.439894,
       "dot": 11323632250.926512,
       "yfi": 11087673.10460544,
       "usd": 82385345574.59445,
       "aed": 302597255028.2064,
       "ars": 15916881719149.86,
       "aud": 119681191516.21309,
       "bdt": 8755482086988.958,
       "bhd": 31048400416.00623,
       "bmd": 82385345574.59445,
       "brl": 425775704464.0607,
       "cad": 111231832859.42825,
       "chf": 76298881014.23438,
       "clp": 65824243407189.44,
       "cny": 566308626945.2042,
       "czk": 1830599989492.4634,
       "dkk": 574460821660.5018,
       "eur": 77165410078.9879,
       "gbp": 67936438897.03096,
       "hkd": 646308916765.4137,
       "huf": 29514049066811.99,
       "idr": 1253786893536122.8,
       "ils": 299516866957.1721,
       "inr": 6827385219909.886,
       "jpy": 11106842152648.115,
       "krw": 107307983702787.02,
       "kwd": 25253332822.943676,
       "lkr": 29844848308566.582,
       "mmk": 173124028944238.3,
       "mxn": 1516142457729.9946,
       "myr": 365173044259.38965,
       "ngn": 37935980076733.375,
       "nok": 846233434871.2831,
       "nzd": 132310864992.79854,
       "php": 4531276803874.988,
       "pkr": 21620374622807.055,
       "pln": 366311692120.5763,
       "rub": 6183019773446.563,
       "sar": 309011613263.9531,
       "sek": 850635448656.0233,
       "sgd": 110247492750.50322,
       "thb": 2849317773033.7397,
       "try": 1554866865563.8777,
       "twd": 2510536874229.172,
       "uah": 3029943606324.102,
       "vef": 8249244652.384122,
       "vnd": 1954112601716578.5,
       "zar": 1503700622841.3193,
       "xdr": 61936973261.59765,
       "xag": 3757684587.830485,
       "xau": 44818451.84603521,
       "bits": 3355991609996.636,
       "sats": 335599160999663.6
     },
     "market_cap_percentage": {
       "btc": 40.63159362950543,
       "eth": 17.276249685177124,
       "usdt": 6.040024457301592,
       "bnb": 4.234668448130549,
       "usdc": 3.6044603019171833,
       "xrp": 1.6926322054165759,
       "ada": 1.1812570717239976,
       "okb": 1.093024889359383,
       "busd": 1.078309474634941,
       "matic": 1.070685090841501
     },
     "market_cap_change_percentage_24h_usd": -1.5632023142247535,
     "updated_at": 1676995756
   }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc" }) {
            return item.value.asPercentString()
        }
        return ""
    }
}
