//
//  GetSimilarSeriesRequest.swift
//  GetSimilarSeriesRequest
//
//  Created by anduser on 30.09.21.
//

import Foundation

struct GetSimilarSeriesRequest: Request {
  
  let serieId: Int
  let page: Int
    
  var path: String {
    "/tv/\(serieId)/similar"
  }
  
  var parameters: [String: String]? {
    ["api_key": Environment.current.apiKey,
     "page": String(page)]
  }
}
