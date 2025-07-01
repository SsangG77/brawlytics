//
//  SettingView.swift
//  Brawlytics
//
//  Created by 차상진 on 7/1/25.
//

import SwiftUI

struct SettingView: View {
    
    @FocusState var isFocused: Bool
    @State var text: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                
                VStack {
                    TextField("플레이어 태그 입력", text: $text)
                        .padding()
                        .roundedCornerWithBorder(
                            lineWidth: isFocused ? 6 : 3,
                            backgroundColor: .white
                        )
                        .animation(.easeInOut(duration: 0.3), value: isFocused)
                        .padding()
                        .focused($isFocused)
                    
                    Spacer()
                    
                    
                    Button("저장") {
                       print("입력된 텍스트: \(text)")
                   }
                    .frame(width: 200)
                    .disabled(!isFocused)
                    .foregroundColor(isFocused ? .black : .secondary)
                    .padding()
                    .roundedCornerWithBorder(
                        lineWidth: isFocused ? 3 : 0,
                        backgroundColor: isFocused ? Color.blue.opacity(0.3) : .gray
                    )
                    .animation(.easeInOut(duration: 0.3), value: isFocused)
                    
                }
            }
            .navigationTitle("Setting")
                
        }
            
    }
}

#Preview {
    SettingView()
    
}
