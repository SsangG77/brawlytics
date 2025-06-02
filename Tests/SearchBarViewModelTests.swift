//
//  SearchBarViewModelTests.swift
//  BrawlyticsTests
//
//  Created by 차상진 on 5/28/25.
//

import XCTest
@testable import Brawlytics

final class SearchBarViewModelTests: XCTestCase {

    var viewModel: SearchBarViewModel! = nil
    
    override func setUpWithError() throws {
        // 여기에 설정 코드를 넣으세요. 이 메서드는 클래스의 각 테스트 메서드가 호출되기 전에 호출됩니다.
        viewModel = SearchBarViewModel(useCase: MockSearchBarUseCase())
    }

    override func tearDownWithError() throws {
        // 여기에 해체 코드를 넣으세요. 이 메서드는 클래스의 각 테스트 메서드가 호출된 후에 호출됩니다.
        viewModel = nil
    }

    func testSaveSearch() throws {
        // 이는 기능 테스트 사례의 예입니다.
        // XCTAssert 및 관련 함수를 사용하여 테스트 결과가 올바른지 확인하세요.
        // XCTest용으로 작성하는 모든 테스트에는 throws 및 async 주석을 추가할 수 있습니다.
        // 테스트에서 처리되지 않은 오류가 발생할 때 예기치 않은 실패를 생성하도록 테스트에 throws를 표시하세요.
        // 비동기 코드가 완료될 때까지 기다릴 수 있도록 테스트에 async를 표시하세요. 나중에 어설션을 사용하여 결과를 확인하세요.
        let testText = "testText"
        viewModel.saveSearchText(testText)
        
        XCTAssertEqual(viewModel.getSearchHistory(), [testText])
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
