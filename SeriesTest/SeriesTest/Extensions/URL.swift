//
//  URL.swift
//  URL
//
//  Created by anduser on 29.09.21.
//

import Foundation

extension URL {
  
  func appending(
    path: String,
    queryItems: [URLQueryItem]?
  ) -> URL? {
    var urlComponetns = URLComponents(
      url: appendingPathComponent(path),
      resolvingAgainstBaseURL: false
    )
    
    if let queryItems = queryItems {
      urlComponetns?.queryItems = queryItems
    }
    
    return urlComponetns?.url
  }
}

