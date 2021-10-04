//
//  SeriesViewModelTests.swift
//  SeriesViewModelTests
//
//  Created by anduser on 4.10.21.
//

import XCTest
@testable import SeriesTest

class SeriesViewModelTests: XCTestCase {
    
  var sut: SeriesViewModel!
  var webService: WebServiceMock!
    
  override func setUp() {
    super.setUp()
    webService = WebServiceMock()
    Current.webService = webService
    
    sut = SeriesViewModel()
  }
  
  func testFetchPopularSeries_PassValidData_ShouldGetResponse() {
    let promise = expectation(description: "fetching popular series")
    
    // Given
    webService.fetchPopularSeriesCompletion = FetchPopularSeriesCompletionType
      .one(PopularSeriesMock.valid)
      .result
    
    // When
    sut.fetchPopularSeries()
    
    DispatchQueue.main.async {
      promise.fulfill()
    }
    waitForExpectations(timeout: 1)
    
    // Then
    XCTAssertEqual(webService.fetchPopularSeriesCallsCount, 1)
    XCTAssertEqual(sut.seriesCount(isFiltering: false), 5)
  }
   
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
}
