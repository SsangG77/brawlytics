//
//  CalculateViewModel.swift
//  Brawlytics
//
//  Created by 차상진 on 11/7/24.
//

import Foundation
import SwiftUI

class CalculateViewModel: ObservableObject {
    
    @Published var brawlers: [Brawler] = []
    @Published var isLoading: Bool = false
    private let calculateUseCase: CalculateUseCase
    
    init(calculateUseCase: CalculateUseCase) {
        self.calculateUseCase = calculateUseCase
    }

    
    
    func getBrawlers(_ searchText: String) {
        isLoading = true
        self.calculateUseCase.getUserBrawlers(searchText: searchText) { brawlers in
            DispatchQueue.main.async {
                self.brawlers = brawlers
                self.isLoading = false
            }
        }
    }
    
    func findMyBrawler(brawlerName: String) -> Brawler {
        return calculateUseCase.findMyBrawler(brawlerName: brawlerName)
    }
    
    @ViewBuilder
    func DynamicStack<Content: View>(isPad: Bool, @ViewBuilder content: () -> Content) -> some View {
        if isPad { //아이패드일때
            HStack {
                content()
            }
            .frame(height: 130)
            
        } else {
            ZStack {
                content()
            }
            
        }
    }
    
}
