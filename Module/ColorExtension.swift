//
//  ColorExtension.swift
//  Brawlytics
//
//  Created by 차상진 on 11/3/24.
//

import Foundation
import SwiftUI

extension Color {
    
    // default
    static let deepColor = Color(hexString: "182C49")
    static let lightColor = Color(hexString: "6D8CB9")
    static let backgroundColor = Color(hexString: "37475F")
    
    //win
    static let deepRed = Color(hexString: "812323")
    static let lightRed = Color(hexString: "C76363")
    
    //lose
    static let deepBlue = Color(hexString: "16328F")
    static let lightBlue = Color(hexString: "586590")
    
    // showDown
    static let deepGreen = Color(hexString: "1B6424")
    static let lightGreen = Color(hexString: "3CBA59")
    
    
    init(hexString: String, opacity: Double = 1.0) {
        let hex: Int = Int(hexString, radix: 16)!
        
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
