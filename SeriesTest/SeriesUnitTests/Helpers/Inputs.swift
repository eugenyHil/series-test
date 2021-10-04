//
//  Inputs.swift
//  Inputs
//
//  Created by anduser on 4.10.21.
//

import Foundation
@testable import SeriesTest

enum SerieMock {
  
  static let valid = Serie(
    id: 1,
    name: "1",
    posterPath: nil,
    voteAverage: 1,
    overview: "1")
}

enum PopularSeriesMock {

  static let valid = PopularSeries(
    page: 1,
    results: [
      Serie(id: 1, name: "1", posterPath: nil, voteAverage: 1, overview: "1"),
      Serie(id: 2, name: "2", posterPath: nil, voteAverage: 2, overview: "2"),
      Serie(id: 3, name: "3", posterPath: nil, voteAverage: 3, overview: "3"),
      Serie(id: 4, name: "4", posterPath: nil, voteAverage: 4, overview: "4"),
      Serie(id: 5, name: "5", posterPath: nil, voteAverage: 5, overview: "5")
    ])
}

enum SimilarSeriesMock {

  static let valid = SimilarSeries(
    page: 1,
    results: [
      SimilarSerie(id: 1, name: "1", posterPath: nil),
      SimilarSerie(id: 2, name: "2", posterPath: nil),
      SimilarSerie(id: 3, name: "3", posterPath: nil),
      SimilarSerie(id: 4, name: "4", posterPath: nil)
    ])
}
