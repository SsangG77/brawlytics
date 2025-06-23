//
//  RoundedCorner.swift
//  Brawlytics
//
//  Created by 차상진 on 11/5/24.
//

import Foundation
import SwiftUI


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
//    func roundedCornerWithBorder(
//        lineWidth: CGFloat = 3,
//        borderColor: Color = .black,
//        backgroundColor: Color = Color.lightColor,
//        radius: CGFloat = 20,
//        corners: UIRectCorner = [.allCorners]
//    ) -> some View {
//        clipShape(RoundedCorner(radius: radius, corners: corners))
//            .overlay(RoundedCorner(radius: radius, corners: corners)
//            .stroke(borderColor, lineWidth: lineWidth))
//            .background(
//                RoundedRectangle(cornerRadius: radius)
//                    .fill(backgroundColor)
//            )
//    }
    
    func roundedCornerWithBorder(
        lineWidth: CGFloat = 5,
        borderColor: Color = .black,
        backgroundColor: Color = Color.blue.opacity(0.3),
        radius: CGFloat = 20,
        corners: UIRectCorner = [.allCorners]
    ) -> some View {
        self
            .background(backgroundColor)
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(borderColor, lineWidth: lineWidth)
            )
    }
}
