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

    private(set) var answers: [Questions] = []
    private(set) var ans_count = 0
    private(set) var boyfriend_count = 0
    private(set) var age_ave = 0
    private(set) var win_count = 0

    init(context: ModelContext? = nil) {
        self.context = context
        fetchAnswers()
    }

    func fetchAnswers() {
        let fetchDescriptor = FetchDescriptor<Questions>(sortBy: [SortDescriptor(\.timestamp)])
        answers = (try? (context?.fetch(fetchDescriptor) ?? [])) ?? []
        ans_count = answers.count
        reload()
    }

    func reload() {
        var bf_count = 0
        var age_sum = 0
        var w_count = 0

        for item in answers {
            bf_count += item.haveaBoyFriend
            age_sum += item.girlAge
            w_count += item.myGirlFriend
        }

        boyfriend_count = bf_count
        win_count = w_count

        if age_sum != 0 || ans_count != 0 {
            age_ave = age_sum / age_sum
        } else {
            age_ave = 0
        }
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

    func delete(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context?.delete(answers[index])
            }
        }
        try? context?.save()

        fetchAnswers()
    }
}

