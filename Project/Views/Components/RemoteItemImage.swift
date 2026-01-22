//
//  RemoteItemImage.swift
//  Brawlytics
//
//  Created by Claude on 1/4/26.
//

import SwiftUI
import Kingfisher

/// 서버에서 브롤러 아이템 이미지를 로드하는 재사용 가능한 컴포넌트
struct RemoteItemImage: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    let isOwned: Bool

    init(url: URL?, width: CGFloat, height: CGFloat, isOwned: Bool = true) {
        self.url = url
        self.width = width
        self.height = height
        self.isOwned = isOwned
    }

    var body: some View {
        if let url = url {
            KFImage(url)
                .placeholder {
                    // 로딩 중 표시
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                        ProgressView()
                            .scaleEffect(0.7)
                    }
                    .frame(width: width, height: height)
                }
                .retry(maxCount: 3, interval: .seconds(0.5))
                .onSuccess { result in
                    print("✅ Image loaded: \(url.absoluteString)")
                }
                .onFailure { error in
                    print("❌ Image load failed: \(url.absoluteString)")
                    print("   Error: \(error)")
                }
                .fade(duration: 0.3)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .saturation(isOwned ? 1 : 0)
                .colorMultiply(isOwned ? Color.white : Color(hexString: "585858"))
                .onAppear {
                    print("🔍 Attempting to load image: \(url.absoluteString), isOwned: \(isOwned)")
                }
        } else {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.clear)
                .frame(width: width, height: height)
                .onAppear {
                    print("⚠️ URL is nil for RemoteItemImage")
                }
        }
    }
}

/// 서버에서 브롤러 프로필 이미지를 로드하는 컴포넌트
struct RemoteBrawlerImage: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat

    init(url: URL?, width: CGFloat, height: CGFloat) {
        self.url = url
        self.width = width
        self.height = height
    }

    var body: some View {
        if let url = url {
            KFImage(url)
                .placeholder {
                    // 로딩 중 표시
                    ZStack {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                        ProgressView()
                            .scaleEffect(0.7)
                    }
                    .frame(width: width, height: height)
                }
                .retry(maxCount: 3, interval: .seconds(0.5))
                .onSuccess { result in
                    print("✅ Brawler image loaded: \(url.absoluteString)")
                }
                .onFailure { error in
                    print("❌ Brawler image load failed: \(url.absoluteString)")
                    print("   Error: \(error)")
                }
                .resizable()
                .fade(duration: 0.3)
                .scaledToFill()
                .frame(width: width, height: height)
                .clipped()
                .onAppear {
                    print("🔍 Attempting to load brawler image: \(url.absoluteString)")
                }
        } else {
            Rectangle()
                .fill(Color.clear)
                .frame(width: width, height: height)
                .onAppear {
                    print("⚠️ URL is nil for RemoteBrawlerImage")
                }
        }
    }
}

