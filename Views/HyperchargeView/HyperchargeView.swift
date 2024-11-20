//
//  HyperchargeView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/19/24.
//

import SwiftUI

struct HyperchargeView: View {
    
    @StateObject var viewModel:BrawlersViewModel = BrawlersViewModel()
    
    
    var body: some View {
        ScrollView {
            ForEach($viewModel.brawlers_standard, id:\.id) { brawler_st in
                
                if brawler_st.hypercharge.wrappedValue != "" {
                    SingleHyperchargeView(hyperchargeName: brawler_st.hypercharge)
                        .padding([.top, .bottom], 7)
                }
                
            }
            
        }
        .ignoresSafeArea(.keyboard, edges: .all)
        .frame(width: UIScreen.main.bounds.width, height: .infinity)
        .background(Color(hexString: "37475F"))
    }
}




struct SingleHyperchargeView: View {
    
    var totalHeight: CGFloat = 60
    @State var width: CGFloat = UIScreen.main.bounds.width * 0.9
    
    @State private var isOn = false
    @StateObject var viewModel = BrawlersViewModel()
    
    
    //Binding
    @Binding var hyperchargeName:String
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: width, height: totalHeight)
                .cornerRadius(15)
                .foregroundColor(Color(hexString: "576E90"))
                .roundedCornerWithBorder(lineWidth: 5, borderColor: .black, radius: 15, corners: [.allCorners])
            
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
            
        }
        .onAppear {
            isOn = viewModel.judgeHypercharge(hyperchargeName)
        }
    }
}

#Preview {
    HyperchargeView()
}

//
//struct CheckBoxView: View {
//    @Binding var checked: Bool
//
//    var body: some View {
//       
//    }
//}
