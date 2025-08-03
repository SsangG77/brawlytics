//
//  InterstitialAdManager.swift
//  Brawlytics
//
//  Created by 차상진 on 5/31/25.
//

import Foundation
import GoogleMobileAds

class InterstitialAdManager: NSObject, FullScreenContentDelegate {
    private var interstitialAd: InterstitialAd?
    private var lastAdShowTime: Date?
    private let adCooldownInterval: TimeInterval = 300 // 5분 (초 단위)
    
    var onAdStart: (() -> Void)? // 시작 클로저
    var onAdDismiss: (() -> Void)? //종료 클로저
    
    func loadAd() async {
        do {
            interstitialAd = try await InterstitialAd.load(
                with: AdManager.shared.getId(.unit), request: Request())
            interstitialAd?.fullScreenContentDelegate = self
        } catch {
            print("광고 로드 실패 : \(error.localizedDescription)")
        }
    }
    
    func showAd(from root: UIViewController) {
        // 마지막 광고 표시 시간 확인
        if let lastShowTime = lastAdShowTime {
            let timeSinceLastAd = Date().timeIntervalSince(lastShowTime)
            if timeSinceLastAd < adCooldownInterval {
                print("광고 쿨다운 중: \(Int(adCooldownInterval - timeSinceLastAd))초 남음")
                onAdDismiss?()
                return
            }
        }
        
        guard let ad = interstitialAd else {
            print("광고 준비 안됨")
            onAdDismiss?()
            return
        }
        
        print("showAd---------print")
        lastAdShowTime = Date() // 광고 표시 시간 기록
        onAdStart?()
        ad.present(from: root)
    }

    // MARK: FullScreenContentDelegate

    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        print("광고 닫힘, 광고 초기화")
        interstitialAd = nil
        Task {
            await loadAd()
        }
        print("adDidDismissFullScreenContent---------print")
        onAdDismiss?()
    }

    func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
//           print("광고 노출 기록")
    }

    func adDidRecordClick(_ ad: FullScreenPresentingAd) {
//           print("광고 클릭 기록")
    }

    func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
//           print("광고 곧 표시됨")
    }

    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
//           print("광고 곧 닫힘")
    }

    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("광고 표시 실패: \(error.localizedDescription)")
    }
}

class AdManager {
    
    enum IdType {
        case test
        case unit
    }
    
    static let shared = AdManager()
    
    func getId(_ type: IdType) -> String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) else {
            return "ca-app-pub-3940256099942544/4411468910"
        }
        let key = (type == .test) ? "testId" : "adUnitId"
        return dict[key] as? String ?? ""
    }
}
