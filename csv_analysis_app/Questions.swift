//
//  Questions.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/15.
//

import Foundation
import SwiftData

@Model
final class Questions {
    let uuid = UUID()
    var timestamp: String
    var haveaBoyFriend: Int
    var cuteSize: Int
    var girlAge: Int
    var atmosphere: Int
    var pickingUpGirls: Int
    var myGirlFriend: Int

    init( haveaBoyFriend: Int, cuteSize: Int, girlAge: Int, atmosphere: Int, pickingUpGirls: Int, myGirlFriend: Int) {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        self.timestamp = df.string(from: date)

        self.haveaBoyFriend = haveaBoyFriend
        self.cuteSize = cuteSize
        self.girlAge = girlAge
        self.atmosphere = atmosphere
        self.pickingUpGirls = pickingUpGirls
        self.myGirlFriend = myGirlFriend
    }
}
