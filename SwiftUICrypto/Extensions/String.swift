//
//  String.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-24.
//

import Foundation

extension String {
    var removeHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
