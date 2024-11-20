//
//  test.swift
//  Brawlytics
//
//  Created by 차상진 on 11/16/24.
//

import SwiftUI

struct test: View {
    
    @State private var isGrayScale: Bool = true
    
    var body: some View {
        Image("CHEAT CARTRIDGE")
            .saturation(0) // 완전히 흑백으로
            .colorMultiply(Color(hexString: "585858")) // 더 어둡게 조정
    }
}

#Preview {
    test()
}
