//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by MOK Lai Wo on 2023-02-22.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
