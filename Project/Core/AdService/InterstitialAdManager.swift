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
    
    
    func loadAd() async {
        print("광고 로드")
        do {
            interstitialAd = try await InterstitialAd.load(
                with: AdManager.testId.rawValue, request: Request())
            interstitialAd?.fullScreenContentDelegate = self
        } catch {
            print("광고 로드 실패 : \(error.localizedDescription)")
        }
    }
    
    func showAd(from root: UIViewController) {
           guard let ad = interstitialAd else {
               print("광고 준비 안됨")
               return
           }
            ad.present(from: root)
       }

       // MARK: FullScreenContentDelegate

       func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
           print("광고 닫힘, 광고 초기화")
           interstitialAd = nil
           Task {
               await loadAd()
           }
       }

       func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
           print("광고 노출 기록")
       }

       func adDidRecordClick(_ ad: FullScreenPresentingAd) {
           print("광고 클릭 기록")
       }

       func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
           print("광고 곧 표시됨")
       }

       func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
           print("광고 곧 닫힘")
       }

       func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
           print("광고 표시 실패: \(error.localizedDescription)")
       }
}

enum AdManager: String {
    case testId = "ca-app-pub-3940256099942544/4411468910"
    case adId = "ca-app-pub-3545555975398754~5711492641"
}
