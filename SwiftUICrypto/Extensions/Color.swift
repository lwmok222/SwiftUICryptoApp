//
//  Color.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-16.
//

import SwiftUI
import Foundation

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
