//
//  SingleBattleLogViewSkeleton.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import Foundation
import SwiftUI


struct SingleBattleLogViewSkeleton: View {
    var body: some View {
        OverlapCardView(vm: OverlapCardViewModel(type: .win), frontView: {
            // logView skeleton
            VStack(spacing: 10) {
                HStack(spacing: 20) {
                    ForEach(0..<2) { _ in // Two teams
                        VStack {
                            ForEach(0..<3) { _ in // Members in a team
                                HStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 50, height: 50)
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 80, height: 15)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .redacted(reason: .placeholder)
        }, backView: {
            // header skeleton
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 40, height: 40)
                VStack(alignment: .leading, spacing: 5) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 20)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 80, height: 15)
                }
                .padding(.leading, 15)
                Spacer()
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.5))
                    .frame(width: 60, height: 30)
            }
            .padding(.horizontal, 25)
            .redacted(reason: .placeholder)
        })
    }
}
