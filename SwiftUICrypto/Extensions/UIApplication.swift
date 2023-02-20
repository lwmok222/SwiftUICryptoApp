//
//  UIApplication.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-20.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
