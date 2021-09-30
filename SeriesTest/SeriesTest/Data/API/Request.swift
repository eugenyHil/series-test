//
//  Request.swift
//  Request
//
//  Created by anduser on 29.09.21.
//

import Foundation

protocol Request {
  
  var baseUrl: URL { get }
  var url: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: [String: String]? { get }
}

extension Request {
  
  var method: HTTPMethod  {
    .get
  }
  
  var baseUrl: URL {
    Environment.current.baseUrl
  }
  
  var url: URL {
    baseUrl.appending(path: path, queryItems: queryItems())!
  }
  
  var urlRequest: URLRequest {
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = method.rawValue
    return urlRequest
  }
  
  private func queryItems() -> [URLQueryItem]? {
    parameters?.map {
      URLQueryItem(name: $0.key, value: $0.value)
    }
  }
}
