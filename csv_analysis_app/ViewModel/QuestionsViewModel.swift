//
//  QuestionsViewModel.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/15.
//

import SwiftUI
import SwiftData

class QuestionsViewModel: ObservableObject {
    var context: ModelContext? = nil

    @Published var inputAnswers: [[Int]] = [
        [2,0,18,0,2,2],
        [2,0,18,0,2,2],
        [2,0,18,0,2,2],
        [2,0,18,0,2,2],
    ]

    var answers: [Questions] = []

    init(context: ModelContext? = nil) {
        self.context = context
        fetchAnswers()
        print(answers)
    }

    func fetchAnswers() {
        let fetchDescriptor = FetchDescriptor<Questions>(sortBy: [SortDescriptor(\.timestamp)])
        answers = (try? (context?.fetch(fetchDescriptor) ?? [])) ?? []
    }

    func add(numberOfPeople: Int) {
        for i in 0 ..< numberOfPeople {
            let data = Questions(haveaBoyFriend: inputAnswers[i][0], cuteSize: inputAnswers[i][1], girlAge: inputAnswers[i][2], atmosphere: inputAnswers[i][3], pickingUpGirls: inputAnswers[i][4], myGirlFriend: inputAnswers[i][5])
            print("data", data)
            context?.insert(data)
        }
        try? context?.save()

        fetchAnswers()
        inputAnswers = [
            [2,0,18,0,2,2],
            [2,0,18,0,2,2],
            [2,0,18,0,2,2],
            [2,0,18,0,2,2],
        ]
    }
}

