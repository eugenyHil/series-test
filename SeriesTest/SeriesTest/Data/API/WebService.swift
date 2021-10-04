//
//  WebService.swift
//  WebService
//
//  Created by anduser on 29.09.21.
//

import Foundation

typealias PopularSeriesCompletion = (Result<PopularSeries, NetworkError>) -> Void
typealias SimilarSeriesCompletion = (Result<SimilarSeries, NetworkError>) -> Void

protocol WebServiceProtocol {
  
  func fetchPopularSeries(
    page: Int,
    completion: @escaping PopularSeriesCompletion
  )
  func fetchSimilarSeries(
    serieId: Int,
    page: Int,
    completion: @escaping SimilarSeriesCompletion
  )
}

final class WebService: WebServiceProtocol {
  
  private let session = URLSession.shared
  
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  func fetchPopularSeries(
    page: Int,
    completion: @escaping PopularSeriesCompletion
  ) {
    let request = GetPopularSeriesRequest(page: page)
    session.dataTask(
      with: request,
      decoder: decoder
    ) { result in
      completion(result)
    }.resume()
  }
  
  func fetchSimilarSeries(
    serieId: Int,
    page: Int,
    completion: @escaping SimilarSeriesCompletion
  ) {
    let request = GetSimilarSeriesRequest(
      serieId: serieId,
      page: page)
    session.dataTask(
      with: request,
      decoder: decoder
    ) { result in
      completion(result)
    }.resume()
  }
}
