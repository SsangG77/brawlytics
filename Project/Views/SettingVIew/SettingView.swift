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
    @State private var loadedPlayerTag: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundColor.ignoresSafeArea()
                    .onTapGesture {
                        isFocused = false
                    }
                
                GeometryReader { geometry in
                    ScrollView {
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
                            
                            Text(loadedPlayerTag.isEmpty ? "플레이어 태그를 저장하세요" : "저장된 태그: \(loadedPlayerTag)")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                                .padding(.bottom)
                            
                            Spacer()
                            
                            Button("저장") {
                                var processedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                                if processedText.hasPrefix("#") {
                                    processedText.removeFirst()
                                }
                                processedText = processedText.replacingOccurrences(of: " ", with: "") // 모든 공백 제거
                                
                                // 유효성 검사: 알파벳과 숫자로만 이루어져 있는지 확인
                                let alphanumericCharacterSet = CharacterSet.alphanumerics
                                if processedText.rangeOfCharacter(from: alphanumericCharacterSet.inverted) != nil {
                                    alertMessage = "플레이어 태그는 알파벳과 숫자로만 이루어져야 합니다."
                                    showAlert = true
                                    return // 저장 로직 중단
                                }
                                
                                let finalPlayerTag: String
                                if processedText.isEmpty {
                                    finalPlayerTag = "" // 입력이 비어있으면 빈 문자열 저장
                                } else {
                                    finalPlayerTag = "#" + processedText.uppercased()
                                }
                                
                                UserDefaults.standard.set(finalPlayerTag, forKey: "playerTag")
                                loadedPlayerTag = finalPlayerTag // 저장 후 즉시 업데이트
                                print("입력된 텍스트: \(text) -> 저장된 태그: \(finalPlayerTag)")
                            }
                            .frame(width: 200)
                            .disabled(text.isEmpty)
                            .foregroundColor(text.isEmpty ? .secondary : .black)
                            .padding()
                            .roundedCornerWithBorder(
                                lineWidth: text.isEmpty ? 0 : 3,
                                backgroundColor: text.isEmpty ? .gray : Color.blue.opacity(0.3)
                            )
                            .animation(.easeInOut(duration: 0.3), value: text.isEmpty)
                            .padding(.bottom, 40)
                        }
                        .frame(minHeight: geometry.size.height)
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .navigationTitle("Setting")
            .onAppear {
                loadedPlayerTag = UserDefaults.standard.string(forKey: "playerTag") ?? ""
            }
            .alert("유효성 검사 실패", isPresented: $showAlert) {
                Button("확인") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    SettingView()
    
}
