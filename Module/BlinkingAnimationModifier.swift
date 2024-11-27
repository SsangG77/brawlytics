//
//  BlinkingAnimationModifier.swift
//  Brawlytics
//
//  Created by 차상진 on 11/23/24.
//

import SwiftUI

struct BlinkingAnimationModifier: AnimatableModifier {
    
    var shouldShow:Bool
    
    
    var opacity:Double
    
    var animatableData: Double {
        get { opacity }
        set { opacity = newValue }
        
    }
    
    func body(content: Content) -> some View {
        content.overlay(
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color(hexString: "576E90"))
                    .zIndex(0)
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(hexString: "37475F"))
                    .opacity(self.opacity)
                    .zIndex(1)
                    
            }
            .opacity(shouldShow ? 1 : 0)
        )
    }
    
}

