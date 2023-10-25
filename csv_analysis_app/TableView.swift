//
//  TableView.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/16.
//

import SwiftUI
import SwiftData

struct TableView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @EnvironmentObject var vm: QuestionsViewModel
    var body: some View {
        VStack {
            List {
                ForEach(vm.answers) { item in
                    HStack(spacing: 12) {
                        Text(item.timestamp)
                        Text(String(item.haveaBoyFriend))
                        Text(String(item.cuteSize))
                        Text(String(item.girlAge))
                        Text(String(item.atmosphere))
                        Text(String(item.pickingUpGirls))
                        Text(String(item.myGirlFriend))
                    }
                }
                .onDelete(perform: vm.delete)
            }
        }
        .navigationTitle("テーブル")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 17, weight: .medium))
                        Text("戻る")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
        .onAppear {
            vm.fetchAnswers()
        }
    }
}

#Preview {
    TableView()
        .environmentObject(QuestionsViewModel())
}
