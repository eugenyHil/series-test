//
//  WebService.swift
//  WebService
//
//  Created by anduser on 29.09.21.
//

import Foundation

typealias PopularSeriesCompletion = (Result<PopularSeries, NetworkError>) -> Void

protocol WebService {
  
  func fetchPopularSeries(page: Int, completion: @escaping PopularSeriesCompletion)
}

final class WebServiceImp: WebService {
  
  private let session: URLSession = URLSession.shared
  private let decoder: JSONDecoder = JSONDecoder()
  
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
}
