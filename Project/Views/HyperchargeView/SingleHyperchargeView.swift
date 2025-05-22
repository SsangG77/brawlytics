//
//  SingleHyperchargeView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct SingleHyperchargeView: View {
    
    var totalHeight: CGFloat = 60
    
    @State private var isOn = false
    @StateObject var viewModel:BrawlersViewModel
    @EnvironmentObject var appState: AppState
    
    //Binding
    var width:CGFloat
    var hyperchargeName:String
    var brawlerName:String
    
    init(
           width: CGFloat,
           hyperchargeName: String,
           brawlerName: String
       ) {
        self.width = width
        self.hyperchargeName = hyperchargeName
        self.brawlerName = brawlerName
           
        let service = BrawlersService()
        let dataSource = HyperchargeDataSourceImpl()
        let repository = BrawlersRepositoryImpl(service: service, dataSource: dataSource)
        let useCase = BrawlersUseCaseImpl(repository: repository)
        _viewModel = StateObject(wrappedValue: BrawlersViewModel(repository: repository, useCase: useCase, judge: BrawlerJudgeImpl()))
    }
    
    
  
    
    var body: some View {
        ZStack {
            
            HStack {
                Spacer()
                
                Image(brawlerName)
                    .resizable()
                    .scaleEffect(x: -1, y: 1) // X축을 -1로 설정하여 좌우 반전
                    .frame(width: 130, height: 100)
                
            }
            .frame(width:width, height: 64)
            .cornerRadius(15)
            .clipped()

            Rectangle()
                .fill(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(hexString: "FFFFFF", opacity: 0.5), location: 0),
                        .init(color: .clear, location: 1.0)
                    ]),
                    startPoint: .trailing,
                    endPoint: .leading
                ))
                .frame(width: width, height: totalHeight)
                .cornerRadius(15)
                .foregroundColor(Color(hexString: "576E90"))
                .roundedCornerWithBorder(lineWidth: 5, borderColor: isOn ? .black : .white, radius: 15, corners: [.allCorners])
                
            HStack {
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(isOn ? Color(UIColor.systemBlue) : Color.secondary)
                    .onTapGesture {
                        self.isOn.toggle()
                        //체크되어있으면 배열에서 삭제하고 체크되어있지 않으면 배열에 추가
                        if isOn {
                            viewModel.addHyperchargeArray(hyperchargeName)
                        } else {
                            viewModel.removeHyperchargeArray(hyperchargeName)
                        }
                    }
                Image(hyperchargeName)
                    .resizable()
                    .frame(width: 33, height: 40)
                
                Text(hyperchargeName)
                Spacer()
            }//VStack
            .padding(.leading, 30)
            .clipped()
        }
        .clipped()
        .onAppear {
            isOn = viewModel.judgeHypercharge(hyperchargeName)
        }
    }
}
