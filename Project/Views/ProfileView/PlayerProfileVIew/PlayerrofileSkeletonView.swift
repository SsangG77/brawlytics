//
//  SkeletonView.swift
//  Brawlytics
//
//  Created by 차상진 on 7/6/25.
//

import SwiftUI




struct TotalSkeleton: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                UserSectionSkeleton()
                ForEach(0..<5) { _ in // 3개의 브롤러 섹션 스켈레톤 표시
                    BrawlerSectionSkeleton()
                }
            }
            .padding()
        }
    }
}



struct UserSectionSkeleton: View {
    var body: some View {
        OverlapCardView(vm: OverlapCardViewModel(type: .user), frontView: {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 150, height: 40)
                    HStack {
                        Spacer()
                        HStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 30, height: 30)
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 70, height: 20)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .redacted(reason: .placeholder)
        }, backView: {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 3) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 15)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 80, height: 25)
                }
                VStack(alignment: .leading, spacing: 3) {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 15)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 80, height: 25)
                }
                Spacer()
            }
            .padding(.leading, 30)
            .padding(.trailing, 12)
            .redacted(reason: .placeholder)
        })
    }
}

struct BrawlerSectionSkeleton: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            OverlapCardView(vm: OverlapCardViewModel(type: .brawler), frontView: {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 40, height: 40)
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 100, height: 25)
                        .padding(.trailing, 70)
                }
                .padding()
            }, backView: {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 110, height: 25)
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 70, height: 15)
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 50)
                }
                .padding()
            })
            .redacted(reason: .placeholder)
            .frame(height: 210)
        }
    }
}

#Preview {
    TotalSkeleton()
}
