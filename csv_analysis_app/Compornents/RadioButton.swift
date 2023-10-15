//
//  RadioButton.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/15.
//

import SwiftUI

struct RadioButtonModel: Identifiable, Hashable {
    let id = UUID()
    let index: Int
    let text: String

    init(index: Int, text: String) {
        self.index = index
        self.text = text
    }
}

struct RadioButton: View {
    enum Axis {
        case horizontal
        case vertical
    }

    @Binding var selectedIndex: Int
    private let axis: Axis
    private var models: [RadioButtonModel] = []

    init(selectedIndex: Binding<Int>, axis: Axis, texts: [String]) {
        self._selectedIndex = selectedIndex
        self.axis = axis

        var index = 0
        texts.forEach { text in
            let model = RadioButtonModel(index: index, text: text)
            models.append(model)
            index += 1
        }
    }

    var body: some View {
        if axis == .vertical {
            return configureVertical()
        } else {
            return configureHorizontal()
        }
    }

    private func configureHorizontal() -> AnyView {
        return AnyView(
            HStack {
                configure()
            }
        )
    }

    private func configureVertical() -> AnyView {
        return AnyView(
            VStack(alignment: .leading) {
                configure()
            }
        )
    }

    private func configure() -> AnyView {
        return AnyView(
            ForEach(models) { model in
                HStack {
                    if model.index == self.selectedIndex {
                        ZStack {
                            Circle()
                                .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2))
                                .frame(width: 16, height: 16)
                            Circle()
                                .fill(Color.accentColor)
                                .frame(width: 10, height: 10)
                        }
                    } else {
                        Circle()
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 2))
                            .frame(width: 16, height: 16)
                    }
                    Text(model.text).bold()
                        .font(.footnote)
                }
                .onTapGesture {
                    self._selectedIndex.wrappedValue = model.index
                }
            }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    @State static var selectedIndex = 0
    static let texts = ["いない", "いる"]

    static var previews: some View {
        VStack {
            Text("彼氏はいますか？")
            RadioButton(selectedIndex: $selectedIndex, axis: .horizontal, texts: texts)
        }
    }}
