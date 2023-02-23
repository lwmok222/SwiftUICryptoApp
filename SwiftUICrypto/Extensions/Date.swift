//
//  Date.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-23.
//

import Foundation

extension Date {
    // "ath_date": "2021-11-10T14:24:11.849Z",
    
    init(coinGeokoString: String) {
        let formattor = DateFormatter()
        formattor.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formattor.date(from: coinGeokoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormattor: DateFormatter {
        let formattor = DateFormatter()
        formattor.dateStyle = .short
        return formattor
    }
    
    func asShortDateString() -> String {
        return shortFormattor.string(from: self)
    }
}
