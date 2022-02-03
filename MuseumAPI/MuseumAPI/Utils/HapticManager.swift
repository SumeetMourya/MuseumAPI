//
//  HapticManager.swift
//  MuseumAPI
//
//  Created by Sumeet Mourya on 22/01/2022.
//

import Foundation
import SwiftUI

class HapticManager {

    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
