//
//  HomeView.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/06.
//

import SwiftUI

struct HomeView: View {
    var body: some View {


        ZStack {
            Color("bg")
                .ignoresSafeArea()

            VStack {
                SegmentView(imageName: "figure.arms.open", imageColor: .red, rightText: Text("1"), title: "回答人数")
            }
        }
    }
}

#Preview {
    HomeView()
}

struct SegmentView: View {
    let segmentWidth = UIScreen.main.bounds.width / 2 - 30

    let imageName: String
    let imageColor: Color
    let rightText: Text
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 40) {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.white)
                    .frame(width: 20, height: 20)
                    .padding(5)
                    .background(imageColor)
                    .clipShape(Circle())
                
                Spacer()
                
                rightText.bold()
                    .font(.title)
                    .fontDesign(.rounded)
            }
            
            Text(title).bold()
                .foregroundStyle(.gray)
                .font(.callout)
        }
        .frame(width: segmentWidth)
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
