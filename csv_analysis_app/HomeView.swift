//
//  HomeView.swift
//  csv_analysis_app
//
//  Created by 小松虎太郎 on 2023/10/06.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) var context
    
    @EnvironmentObject var vm: QuestionsViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("bg")
                    .ignoresSafeArea()
                
                VStack {
                    Text("ホーム").bold()
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 16) {
                            SegmentView(imageName: "figure.arms.open", imageColor: .blue, rightText: Text("1"), title: "回答人数")
                            
                            SegmentView(imageName: "figure.2.arms.open", imageColor: .red, rightText: Text("1"), title: "彼氏持ち")
                        }
                        
                        HStack(spacing: 16) {
                            SegmentView(imageName: "character.book.closed", imageColor: .black, rightText: Text("1"), title: "平均年齢")
                            
                            SegmentView(imageName: "trophy.fill", imageColor: .gray, rightText: Text("1"), title: "勝利数")
                        }
                    }
                    
                    Spacer()
                    
                    
                    VStack(spacing: 12) {
                        Button {
                            let csv = csv_output(questions: vm.answers)
                            
                            let tmpFile: URL = URL(fileURLWithPath: "data.csv", relativeTo: FileManager.default.temporaryDirectory)
                            if let strm = OutputStream(url: tmpFile, append: false) {
                                strm.open()
                                let BOM = "\u{feff}"
                                strm.write(BOM, maxLength: 3)
                                let data = csv.data(using: .utf8)
                                _ = data?.withUnsafeBytes {
                                    strm.write($0.baseAddress!, maxLength: Int(data?.count ?? 0))
                                }
                                strm.close()
                            }
                            shareApp(shareText: csv, shareLink: tmpFile.absoluteURL  )
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up.circle").bold()
                                
                                Text("出力").bold()
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(.horizontal)
                        }
                        
                        underBotton(icon: "pencil.circle", title: "編集", color: .orange, distinationView: TableView())
                        underBotton(icon: "plus.circle", title: "追加", color: .blue, distinationView: FormView())
                    }
                }
                .padding(.vertical)
            }
        }
        .onAppear{
            vm.context = self.context
            //vm.fetchAnswers()
        }
    }
    
    func underBotton(icon: String, title: String, color: Color, distinationView: some View) -> some View {
        NavigationLink {
            distinationView
        } label: {
            HStack {
                Image(systemName: icon).bold()
                
                Text(title).bold()
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)
        }
    }
}

private func shareApp(shareText: String, shareLink: URL ) {
    let items = [shareLink] as [Any]
    let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
    if UIDevice.current.userInterfaceIdiom == .pad {
        let deviceSize = UIScreen.main.bounds
        if let popPC = activityVC.popoverPresentationController {
            popPC.sourceView = activityVC.view
            popPC.barButtonItem = .none
            popPC.sourceRect = CGRect(x:deviceSize.size.width/2, y: deviceSize.size.height, width: 0, height: 0)
        }
    }
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let rootVC = windowScene?.windows.first?.rootViewController
    rootVC?.present(activityVC, animated: true,completion: {})
}


#Preview {
    HomeView()
        .environmentObject(QuestionsViewModel())
}

struct SegmentView: View {
    let segmentWidth = UIScreen.main.bounds.width / 2 - 48
    
    let imageName: String
    let imageColor: Color
    let rightText: Text
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack() {
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
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
