//
//  FormView.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/15.
//

import SwiftUI

struct FormView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var vm: QuestionsViewModel

    @State private var numberOfPeople = 1

    var body: some View {
            ZStack {
                Color("bg")
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    HStack {
                        Text("対象は何人ですか？").bold()
                            .font(.title3)

                        Spacer()

                        Picker(selection: $numberOfPeople, content: {
                            ForEach(1..<5, id: \.self) { num in
                                Text("\(num)")
                                    .tag(num)
                            }
                        }, label: { Text("Picker") })
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Text("※ 雰囲気は暗め→明るめです。")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Divider()
                        .padding([.horizontal, .bottom])

                    ForEach(0..<numberOfPeople, id: \.self) { i in
                        VStack(spacing: 16) {
                            Text("\(i+1)人目").bold()
                                .font(.title3)
                                .fontDesign(.rounded)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)

                            HStack(spacing: 16) {
                                TwoItemPicker(selectedItem: $vm.inputAnswers[i][0], title: "彼氏が...", texts: ["いない", "いる"])

                                FourItemPicker(selectedItem: $vm.inputAnswers[i][1], title: "かわいい度", rightText: Text("\(vm.inputAnswers[i][1])"))
                            }

                            HStack(spacing: 16) {
                                AgePicker(selectedItem: $vm.inputAnswers[i][2], title: "年齢")

                                FourItemPicker(selectedItem: $vm.inputAnswers[i][3], title: "雰囲気", rightText: Text("\(vm.inputAnswers[i][3])"))
                            }

                            HStack(spacing: 16) {
                                TwoItemPicker(selectedItem: $vm.inputAnswers[i][4], title: "ナンパはいかに...", texts: ["失敗", "成功"])

                                TwoItemPicker(selectedItem: $vm.inputAnswers[i][5], title: "僕に彼女が...", texts: ["いない", "いる"])
                            }

                            Divider()
                                .padding()
                        }
                    }

                    Button {
                        print("###########")
                        print(vm.inputAnswers)
                        vm.add(numberOfPeople: numberOfPeople)
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle").bold()

                            Text("追加").bold()
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding([.horizontal, .bottom])
                    }

                }
                .navigationTitle("追加")
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
        }
    }

    func TwoItemPicker(selectedItem: Binding<Int>, title: String, texts: [String]) -> some View {
        let segmentWidth = UIScreen.main.bounds.width / 2 - 48

        return VStack(alignment: .center, spacing: 12) {
            HStack {
                Text(title).bold()
                    .foregroundStyle(.gray)
                    .font(.callout)

                Spacer()
            }

            RadioButton(selectedIndex: selectedItem, axis: .horizontal, texts: texts)
        }
        .frame(width: segmentWidth, height: 60)
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    func FourItemPicker(selectedItem: Binding<Int>, title: String, rightText: Text) -> some View {
        let segmentWidth = UIScreen.main.bounds.width / 2 - 48

        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title).bold()
                    .foregroundStyle(.gray)
                    .font(.callout)

                Spacer()

                rightText.bold()
                    .fontDesign(.rounded)
            }

            IntSlider(value: selectedItem, in: 0...3, step: 1)
        }
        .frame(width: segmentWidth, height: 60)
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    func AgePicker(selectedItem: Binding<Int>, title: String) -> some View {
        let segmentWidth = UIScreen.main.bounds.width / 2 - 48

        return VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title).bold()
                    .foregroundStyle(.gray)
                    .font(.callout)

                Spacer()
            }

            Picker(selection: selectedItem, content: {
                ForEach(18..<36, id: \.self) { num in
                    Text("\(num)")
                        .tag(num)
                }
            }, label: { Text("Picker") })
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(width: segmentWidth, height: 60)
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    FormView()
        .environmentObject(QuestionsViewModel())
}
