//
//  SeriesDetailsViewModelTests.swift
//  SeriesDetailsViewModelTests
//
//  Created by anduser on 4.10.21.
//

import XCTest
@testable import SeriesTest

class SeriesDetailsViewModelTests: XCTestCase {
    
  var sut: SeriesDetailsViewModel!
  var webService: WebServiceMock!
    
  override func setUp() {
    super.setUp()
    webService = WebServiceMock()
    Current.webService = webService
    
    sut = SeriesDetailsViewModel(serie: SerieMock.valid)
  }
  
  func testFetchSimilarSeries_PassValidData_ShouldGetResponse() {
    let promise = expectation(description: "fetching similar series")
    
    // Given
    webService.fetchSimilarSeriesCompletion = FetchSimilarSeriesCompletionType
      .one(SimilarSeriesMock.valid)
      .result
    
    // When
    sut.fetchSimilarSeries()
    
    DispatchQueue.main.async {
      promise.fulfill()
    }
    waitForExpectations(timeout: 1)
    
    // Then
    XCTAssertEqual(webService.fetchSimilarSeriesCallsCount, 1)
    XCTAssertEqual(sut.series.count, 4)
  }
   
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
}
