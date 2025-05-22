//
//  HyperchargeView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/19/24.
//

import SwiftUI

//@available(iOS 17.0, *)
//struct HyperchargeView: View {
//    
//    @StateObject var viewModel:BrawlersViewModel
//    @State var allBrawlersStandard: [BrawlerStandard] = []
//    
//    init() {
//        let service = BrawlersService()
//        let dataSource = HyperchargeDataSourceImpl()
//        let repository = BrawlersRepositoryImpl(service: service, dataSource: dataSource)
//        let useCase = BrawlersUseCaseImpl()
//        _viewModel = StateObject(wrappedValue: BrawlersViewModel(repository: repository, useCase: useCase))
//        self.allBrawlersStandard = self.viewModel.all_brawlers_standard
//    }
//    
//    var body: some View {
//        if Constants.isPad() {
//            
//            GeometryReader { geo in
//                
//                var width = geo.size.width / 3.5
//                
//                ScrollView {
//                    HStack(alignment: .top) {
//                        VStack {
//                            ForEach(0..<allBrawlersStandard.count) { i in
//                                if i % 3 == 0 {
//                                    if allBrawlersStandard[i].hypercharge.wrappedValue != "" {
//                                        SingleHyperchargeView(width: width, hyperchargeName: allBrawlersStandard[i].hypercharge, brawlerName: allBrawlersStandard[i].name)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(10)
//                        .frame(width: width + 30)
//                        
//                        VStack {
//                            ForEach(0..<allBrawlersStandard.count) { i in
//                                if i % 3 == 1 {
//                                    if allBrawlersStandard[i].hypercharge.wrappedValue != "" {
//                                        SingleHyperchargeView(width: width, hyperchargeName: allBrawlersStandard[i].hypercharge, brawlerName: allBrawlersStandard[i].name)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(10)
//                        .frame(width: width + 30)
//                        
//                        VStack {
//                            ForEach(0..<allBrawlersStandard.count) { i in
//                                if i % 3 == 2 {
//                                    if allBrawlersStandard[i].hypercharge.wrappedValue != "" {
//                                        SingleHyperchargeView(width: width, hyperchargeName: allBrawlersStandard[i].hypercharge, brawlerName: allBrawlersStandard[i].name)
//                                    }
//                                }
//                            }
//                        }
//                        .padding(10)
//                        .frame(width: width + 30)
//                    }
//                    .frame(width: geo.size.width , height: .infinity, alignment: .center)
//                }
//            }
//            .background(Color(hexString: "37475F"))
//        } else {
//            ScrollView {
//                ForEach(allBrawlersStandard, id:\.id) { brawler_st in
//                    
//                    if brawler_st.hypercharge.wrappedValue != "" {
//                        SingleHyperchargeView(width: UIScreen.main.bounds.width * 0.9, hyperchargeName: brawler_st.hypercharge, brawlerName: brawler_st.name)
//                            .padding([.top, .bottom], 7)
//                    }
//                }
//            }
//            .frame(width: UIScreen.main.bounds.width, height: .infinity)
//            .background(Color(hexString: "37475F"))
//        }
//    }
//}


//struct HyperchargeView: View {
//    @StateObject var viewModel: BrawlersViewModel
//
//    init() {
//        let service = BrawlersService()
//        let dataSource = HyperchargeDataSourceImpl()
//        let repository = BrawlersRepositoryImpl(service: service, dataSource: dataSource)
//        let useCase = BrawlersUseCaseImpl()
//        _viewModel = StateObject(wrappedValue: BrawlersViewModel(repository: repository, useCase: useCase))
//    }
//
//    var body: some View {
//        let isPad = Constants.isPad()
//        let columns = viewModel.hyperchargedBrawlersGrouped
//
//        return Group {
//            if isPad {
//                GeometryReader { geo in
//                    let width = geo.size.width / 3.5
//                    ScrollView {
//                        HStack(alignment: .top) {
//                            ForEach(0..<columns.count, id: \.self) { columnIndex in
//                                VStack {
//                                    ForEach(columns[columnIndex], id: \.id) { brawler in
//                                        SingleHyperchargeView(
//                                            width: width,
//                                            hyperchargeName: brawler.hypercharge,
//                                            brawlerName: brawler.name
//                                        )
//                                    }
//                                }
//                                .padding(10)
//                                .frame(width: width + 30)
//                            }
//                        }
//                    }
//                }
//                .background(Color(hexString: "37475F"))
//            } else {
//                ScrollView {
//                    ForEach(viewModel.all_brawlers_standard.filter { !$0.hypercharge.wrappedValue.isEmpty }, id: \.id) { brawler in
//                        SingleHyperchargeView(
//                            width: UIScreen.main.bounds.width * 0.9,
//                            hyperchargeName: brawler.hypercharge,
//                            brawlerName: brawler.name
//                        )
//                        .padding([.top, .bottom], 7)
//                    }
//                }
//                .background(Color(hexString: "37475F"))
//            }
//        }
//    }
//}

struct HyperchargeView: View {
    @StateObject var viewModel: BrawlersViewModel
    @EnvironmentObject var appState: AppState

    init(viewModel: BrawlersViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    var body: some View {
        if Constants.isPad() {
            iPadLayout()
        } else {
            iPhoneLayout()
        }
    }

    @ViewBuilder
    private func iPadLayout() -> some View {
        GeometryReader { geo in
            let width = geo.size.width / 3.5
            let columns = viewModel.hyperchargedBrawlersGrouped

            ScrollView {
                HStack(alignment: .top) {
                    ForEach(0..<columns.count, id: \.self) { columnIndex in
                        VStack {
                            ForEach(columns[columnIndex], id: \.id) { brawler in
                                SingleHyperchargeView(
                                    width: width,
                                    hyperchargeName: brawler.hypercharge,
                                    brawlerName: brawler.name
                                )
                                .environmentObject(appState)
                            }
                        }
                        .padding(10)
                        .frame(width: width + 30)
                    }
                }
            }
        }
        .background(Color(hexString: "37475F"))
    }


    @ViewBuilder
    private func iPhoneLayout() -> some View {
        ScrollView {
            ForEach(viewModel.all_brawlers_standard.filter { !$0.hypercharge.isEmpty }, id: \.id) { brawler in
                SingleHyperchargeView(
                    width: UIScreen.main.bounds.width * 0.9,
                    hyperchargeName: brawler.hypercharge,
                    brawlerName: brawler.name
                )
                .environmentObject(appState)
                .padding([.top, .bottom], 7)
            }
        }
        .background(Color(hexString: "37475F"))
    }
}

