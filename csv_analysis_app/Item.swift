//
//  Item.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/06.
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
