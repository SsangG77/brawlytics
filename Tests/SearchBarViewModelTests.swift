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

    /// 기본 검색어 저장 테스트
    /// - 검색어 저장 후 검색 기록에 포함되어 있는지 확인
    func testSaveSearch() throws {
        let testText = "testText"
        viewModel.saveSearchText(testText)
        
        XCTAssertEqual(viewModel.getSearchHistory(), [testText])
    }
    
    /// 중복 검색어 처리 테스트
    /// - 동일한 검색어를 두 번 저장해도 한 번만 저장되는지 확인
    func testSaveDuplicateSearch() throws {
        let testText = "testText"
        viewModel.saveSearchText(testText)
        viewModel.saveSearchText(testText)
        
        XCTAssertEqual(viewModel.getSearchHistory().count, 1)
        XCTAssertEqual(viewModel.getSearchHistory(), [testText])
    }
    
    /// 여러 검색어 저장 테스트
    /// - 여러 검색어를 순서대로 저장하고 순서가 유지되는지 확인
    func testSaveMultipleSearches() throws {
        let searches = ["test1", "test2", "test3"]
        searches.forEach { viewModel.saveSearchText($0) }
        
        XCTAssertEqual(viewModel.getSearchHistory(), searches)
    }
    
    /// 빈 검색어 처리 테스트
    /// - 빈 문자열이 검색 기록에 저장되지 않는지 확인
    func testSaveEmptySearch() throws {
        viewModel.saveSearchText("")
        XCTAssertTrue(viewModel.getSearchHistory().isEmpty)
    }
    
    /// 특수문자 포함 검색어 테스트
    /// - 특수문자가 포함된 검색어가 정상적으로 저장되는지 확인
    func testSaveSearchWithSpecialCharacters() throws {
        let testText = "test@#$%^&*()"
        viewModel.saveSearchText(testText)
        
        XCTAssertEqual(viewModel.getSearchHistory(), [testText])
    }
    
    /// 한글 검색어 테스트
    /// - 한글이 포함된 검색어가 정상적으로 저장되는지 확인
    func testSaveSearchWithKoreanCharacters() throws {
        let testText = "테스트"
        viewModel.saveSearchText(testText)
        
        XCTAssertEqual(viewModel.getSearchHistory(), [testText])
    }
    
    /// 긴 검색어 테스트
    /// - 매우 긴 검색어가 정상적으로 저장되는지 확인
    func testSaveSearchWithLongText() throws {
        let testText = String(repeating: "a", count: 1000)
        viewModel.saveSearchText(testText)
        
        XCTAssertEqual(viewModel.getSearchHistory(), [testText])
    }
    
    /// 성능 테스트
    /// - 1000개의 검색어를 저장하는 데 걸리는 시간 측정
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            for i in 0..<1000 {
                viewModel.saveSearchText("test\(i)")
            }
        }
    }

}
