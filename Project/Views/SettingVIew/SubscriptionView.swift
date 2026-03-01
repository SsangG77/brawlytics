//
//  SubscriptionView.swift
//  Brawlytics
//
//  Created by 차상진 on 3/1/26.
//

import SwiftUI

struct SubscriptionView: View {

    @StateObject private var adRemovalManager = AdRemovalManager.shared

    var body: some View {
        VStack(spacing: 10) {
            if adRemovalManager.isAdRemoved {
                // 구매 완료
                HStack {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(Color(hexString: "FFD700"))

                    Text(NSLocalizedString("ad_removal_purchased", comment: ""))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.lightGreen)

                    Spacer()
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .roundedCornerWithBorder(
                    lineWidth: 2,
                    borderColor: Color(hexString: "FFD700"),
                    backgroundColor: Color.deepColor,
                    radius: 14
                )
            } else {
                // 미구매 - 구매 버튼
                Button(action: {
                    Task { await adRemovalManager.purchase() }
                }) {
                    HStack {
                        Image(systemName: "nosign")
                            .foregroundColor(Color(hexString: "FFD700"))
                            .font(.system(size: 14))

                        Text(NSLocalizedString("ad_removal_benefit", comment: ""))
                            .font(.system(size: 15))
                            .foregroundColor(.white)

                        Spacer()

                        if adRemovalManager.isPurchasing {
                            ProgressView()
                                .tint(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                        } else {
                            let priceText = adRemovalManager.product?.displayPrice
                                ?? NSLocalizedString("ad_removal_price", comment: "")
                            Text(priceText)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(hexString: "FFD700"))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .roundedCornerWithBorder(
                        lineWidth: 2,
                        borderColor: Color(hexString: "FFD700", opacity: 0.5),
                        backgroundColor: Color.deepColor,
                        radius: 14
                    )
                }
                .disabled(adRemovalManager.isPurchasing)

                // 구매 복원
                Button(action: {
                    Task { await adRemovalManager.restore() }
                }) {
                    Text(NSLocalizedString("ad_removal_restore", comment: ""))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .alert("오류", isPresented: Binding(
            get: { adRemovalManager.errorMessage != nil },
            set: { if !$0 { adRemovalManager.errorMessage = nil } }
        )) {
            Button("확인") { }
        } message: {
            Text(adRemovalManager.errorMessage ?? "")
        }
        .task {
            await adRemovalManager.loadProduct()
        }
    }
}

#Preview("미구매") {
    ZStack {
        Color.backgroundColor.ignoresSafeArea()
        SubscriptionView()
    }
}
