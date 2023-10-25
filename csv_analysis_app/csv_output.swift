//
//  csv_output.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/25.
//

import Foundation

func csv_output(questions: [Questions]) -> String {
    var csv = ""
    do {
        for item in questions {
            var line = ""
            line += item.timestamp + "," // [日時フォーマット結果],
            line += "\"" + String(item.haveaBoyFriend) + "\","
            line += "\"" + String(item.cuteSize) + "\","
            line += "\"" + String(item.girlAge) + "\","
            line += "\"" + String(item.atmosphere) + "\","
            line += "\"" + String(item.pickingUpGirls) + "\","
            line += String(item.myGirlFriend) + "\r\n"
            csv = line + csv
        }
    }
    csv = "時刻,彼氏持ち,かわいい度,年齢,雰囲気,ナンパ成功率,我彼女持？\r\n" + csv
    
    return csv
}

/*
 var timestamp: String
 var haveaBoyFriend: Int
 var cuteSize: Int
 var girlAge: Int
 var atmosphere: Int
 var pickingUpGirls: Int
 var myGirlFriend: Int
 */
