//
//  AdRemovalModalView.swift
//  Brawlytics
//
//  Created by 차상진 on 3/1/26.
//

import SwiftUI

struct AdRemovalModalView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var adRemovalManager: AdRemovalManager

    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "nosign")
                    .font(.system(size: 44))
                    .foregroundColor(Color(hexString: "FFD700"))

                Text(NSLocalizedString("ad_removal_title", comment: ""))
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Text(NSLocalizedString("ad_removal_description", comment: ""))
                    .font(.system(size: 15))
                    .foregroundColor(Color(hexString: "E0E0E0"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)

                // 구매 버튼
                Button(action: {
                    Task {
                        await adRemovalManager.purchase()
                        if adRemovalManager.isAdRemoved {
                            dismiss()
                        }
                    }
                }) {
                    if adRemovalManager.isPurchasing {
                        ProgressView()
                            .tint(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(hexString: "FFD700"))
                            .cornerRadius(14)
                    } else {
                        let priceText = adRemovalManager.product?.displayPrice
                            ?? NSLocalizedString("ad_removal_price", comment: "")
                        Text("\(NSLocalizedString("ad_removal_buy", comment: ""))  \(priceText)")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(hexString: "FFD700"))
                            .cornerRadius(14)
                    }
                }
                .disabled(adRemovalManager.isPurchasing)
                .padding(.horizontal, 40)

                // 복원 버튼
                Button(action: {
                    Task {
                        await adRemovalManager.restore()
                        if adRemovalManager.isAdRemoved {
                            dismiss()
                        }
                    }
                }) {
                    Text(NSLocalizedString("ad_removal_restore", comment: ""))
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                }

                Spacer()

                // 닫기 버튼
                Button(action: {
                    dismiss()
                }) {
                    Text(NSLocalizedString("ad_removal_close", comment: ""))
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.bottom, 30)
                }
            }
        }
        .task {
            await adRemovalManager.loadProduct()
        }
    }
}

#Preview {
    AdRemovalModalView()
        .environmentObject(AdRemovalManager.shared)
}
