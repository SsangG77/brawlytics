//
//  SearchHistoryView.swift
//  Brawlytics
//
//  Created by 차상진 on 5/22/25.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
struct SearchHistoryView: View {
    
    @EnvironmentObject var searchBarViewModel : SearchBarViewModel
    
    @State var iphoneWidth: CGFloat = UIScreen.main.bounds.width * 0.9
    @Binding var ipadWidth: CGFloat
    
    @AppStorage("searchString") var searchString: [String] = []
    
    var body: some View {
            VStack(spacing:0) {
                Spacer()
                HStack {
                    ForEach(searchString, id: \.self) { search in
                        HStack {
                            Spacer()
                            Text(search)
                            Spacer()
                        }
                        .onTapGesture {
                            searchBarViewModel.searchText = search
                        }
                    }
                }
            }
            .padding()
            .frame(width : Constants.isPad() ? ipadWidth : iphoneWidth, height: 75 + 35)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 5)
            )
            .cornerRadius(15)
    }
}
