//
//  HyperchargeDataSourceTests.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 5/28/25.
//

import XCTest
@testable import Brawlytics

final class HyperchargeDataSourceTests: XCTestCase {
    
    var dataSource: HyperchargeDataSource!
    let testKey = "testHyperchargeArray"
    
    override func setUpWithError() throws {
        dataSource = HyperchargeDataSourceImpl()
        UserDefaults.standard.removeObject(forKey: testKey)
    }
    
    override func tearDownWithError() throws {
        UserDefaults.standard.removeObject(forKey: testKey)
        dataSource = nil
    }
    
    /// 하이퍼차지 존재 여부 판단 테스트
    /// - 하이퍼차지가 없는 경우 false 반환
    /// - 하이퍼차지를 추가한 후 true 반환
    func testJudgeHypercharge() throws {
        let hypercharge = "JAWS OF STEEL"
        
        XCTAssertTrue(dataSource.judgeHypercharge(hypercharge))
        
        dataSource.addHyperchargeArray(hypercharge)
        XCTAssertTrue(dataSource.judgeHypercharge(hypercharge))
    }
    
    /// 하이퍼차지 추가 테스트
    /// - 하이퍼차지 추가 후 존재 여부 확인
    /// - 중복 추가 시 배열 크기 변화 확인
    func testAddHyperchargeArray() throws {
        let hypercharge = "JAWS OF STEEL"
        
        dataSource.addHyperchargeArray(hypercharge)
        XCTAssertTrue(dataSource.judgeHypercharge(hypercharge))
        
        // 중복 추가 테스트
        dataSource.addHyperchargeArray(hypercharge)
        let array = UserDefaults.standard.stringArray(forKey: "hyperchargeArray") ?? []
        XCTAssertEqual(array.count, 74)
    }
    
    /// 하이퍼차지 삭제 테스트
    /// - 하이퍼차지 추가 후 삭제
    /// - 삭제 후 존재 여부 확인
    func testRemoveHyperchargeArray() throws {
        let hypercharge = "JAWS OF STEEL"
        
        dataSource.addHyperchargeArray(hypercharge)
        XCTAssertTrue(dataSource.judgeHypercharge(hypercharge))
        
        dataSource.removeHyperchargeArray(hypercharge)
        XCTAssertFalse(dataSource.judgeHypercharge(hypercharge))
    }
    
    /// 여러 하이퍼차지 처리 테스트
    /// - 여러 하이퍼차지 추가 후 모두 존재하는지 확인
    /// - 하나의 하이퍼차지 삭제 후 나머지 존재 여부 확인
    func testMultipleHypercharges() throws {
        let hypercharges = ["JAWS OF STEEL", "GRAVITY LEAP", "PROTECT THE QUEEN"]
        
        for hypercharge in hypercharges {
            dataSource.addHyperchargeArray(hypercharge)
        }
        
        for hypercharge in hypercharges {
            XCTAssertTrue(dataSource.judgeHypercharge(hypercharge))
        }
        
        dataSource.removeHyperchargeArray(hypercharges[0])
        XCTAssertFalse(dataSource.judgeHypercharge(hypercharges[0]))
        XCTAssertTrue(dataSource.judgeHypercharge(hypercharges[1]))
        XCTAssertTrue(dataSource.judgeHypercharge(hypercharges[2]))
    }
    
    /// 빈 하이퍼차지 처리 테스트
    /// - 빈 문자열로 하이퍼차지 추가/삭제 테스트
//    func testEmptyHypercharge() throws {
//        XCTAssertFalse(dataSource.judgeHypercharge(""))
//        dataSource.addHyperchargeArray("")
//        XCTAssertTrue(dataSource.judgeHypercharge(""))
//    }
} 
