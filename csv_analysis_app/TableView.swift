//
//  TableView.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/16.
//

import SwiftUI
import SwiftData

struct TableView: View {
    @Environment(\.modelContext) private var context

    @EnvironmentObject var vm: QuestionsViewModel
    var body: some View {
        VStack {
            ForEach(vm.answers) { item in
                Text(String(item.haveaBoyFriend))
            }
        }
        .onAppear {
            vm.fetchAnswers()
            print(vm.answers)
        }
    }
}

#Preview {
    TableView()
        .environmentObject(QuestionsViewModel())
}
