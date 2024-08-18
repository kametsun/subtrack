//
//  Item.swift
//  subtrack
//
//  Created by 亀窪翼 on 2024/08/18.
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
