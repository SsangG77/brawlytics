//
//  AdRemovalManager.swift
//  Brawlytics
//
//  Created by 차상진 on 3/1/26.
//

import Foundation
import StoreKit

@MainActor
class AdRemovalManager: ObservableObject {

    static let shared = AdRemovalManager()

    static let productId = "com.brawlytics.removeads"

    @Published private(set) var isAdRemoved: Bool = false
    @Published private(set) var product: Product?
    @Published private(set) var isPurchasing: Bool = false
    @Published var errorMessage: String?

    private var transactionListener: Task<Void, Never>?

    init() {
        transactionListener = listenForTransactions()
        Task { await updatePurchaseStatus() }
    }

    deinit {
        transactionListener?.cancel()
    }

    // MARK: - 상품 로드

    func loadProduct() async {
        guard product == nil else { return }
        do {
            let products = try await Product.products(for: [Self.productId])
            product = products.first
        } catch {
            print("상품 로드 실패: \(error)")
        }
    }

    // MARK: - 구매

    func purchase() async {
        errorMessage = nil
        guard let product = product else {
            await loadProduct()
            guard let product = self.product else {
                errorMessage = "상품 정보를 불러올 수 없습니다."
                return
            }
            return await purchaseProduct(product)
        }
        await purchaseProduct(product)
    }

    private func purchaseProduct(_ product: Product) async {
        isPurchasing = true
        defer { isPurchasing = false }

        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                isAdRemoved = true
            case .userCancelled:
                break
            case .pending:
                break
            @unknown default:
                break
            }
        } catch {
            errorMessage = "구매에 실패했습니다."
            print("구매 실패: \(error)")
        }
    }

    // MARK: - 구매 복원

    func restore() async {
        try? await AppStore.sync()
        await updatePurchaseStatus()
    }

    // MARK: - 구매 상태 확인

    func updatePurchaseStatus() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.productID == Self.productId {
                isAdRemoved = true
                return
            }
        }
        isAdRemoved = false
    }

    // MARK: - 트랜잭션 리스너

    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached {
            for await result in Transaction.updates {
                if case .verified(let transaction) = result {
                    await transaction.finish()
                    await MainActor.run {
                        if transaction.productID == AdRemovalManager.productId {
                            self.isAdRemoved = true
                        }
                    }
                }
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let value):
            return value
        }
    }

    enum StoreError: Error {
        case failedVerification
    }
}
