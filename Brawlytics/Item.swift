//
//  Item.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
