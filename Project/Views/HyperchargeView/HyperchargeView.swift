//
//  HyperchargeView.swift
//  Brawlytics
//
//  Created by 차상진 on 11/19/24.
//

import SwiftUI

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

