//
//  URLSession.swift
//  URLSession
//
//  Created by anduser on 29.09.21.
//

import Foundation

extension URLSession {
  
  func dataTask<T: Decodable>(
    with request: Request,
    decoder: JSONDecoder,
    completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
  {
    dataTask(
      with: request.urlRequest
    ) { data, response, error in
      guard let data = data else {
        completion(.failure(.invalidResponseData))
        return
      }
      
      do {
        let decodableItem = try decoder.decode(T.self, from: data)
        completion(.success(decodableItem))
      } catch {
        completion(.failure(.invalidResponseData))
      }
    }
  }
}
