//
//  Mocks.swift
//  Mocks
//
//  Created by anduser on 4.10.21.
//

import Foundation
@testable import SeriesTest

enum FetchPopularSeriesCompletionType {
    
  case failure(NetworkError)
  case one(PopularSeries)
  
  var result: Result<PopularSeries, NetworkError> {
    switch self {
    case let .failure(error):
      return .failure(error)
    case let .one(series):
      return .success(series)
    }
  }
}

enum FetchSimilarSeriesCompletionType {
    
  case failure(NetworkError)
  case one(SimilarSeries)
  
  var result: Result<SimilarSeries, NetworkError> {
    switch self {
    case let .failure(error):
      return .failure(error)
    case let .one(series):
      return .success(series)
    }
  }
}

final class WebServiceMock: WebServiceProtocol {
  
  var fetchPopularSeriesCallsCount = 0
  var fetchPopularSeriesCompletion: Result<PopularSeries, NetworkError>!
  func fetchPopularSeries(
    page: Int,
    completion: @escaping PopularSeriesCompletion
  ) {
    fetchPopularSeriesCallsCount += 1
    completion(fetchPopularSeriesCompletion)
  }
  
  var fetchSimilarSeriesCallsCount = 0
  var fetchSimilarSeriesCompletion: Result<SimilarSeries, NetworkError>!
  func fetchSimilarSeries(
    serieId: Int,
    page: Int,
    completion: @escaping SimilarSeriesCompletion
  ) {
    fetchSimilarSeriesCallsCount += 1
    completion(fetchSimilarSeriesCompletion)
  }
}
