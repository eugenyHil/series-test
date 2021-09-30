//
//  GetPopularSeriesRequest.swift
//  GetPopularSeriesRequest
//
//  Created by anduser on 29.09.21.
//

import Foundation

struct GetPopularSeriesRequest: Request {
  
  let page: Int
    
  var path: String {
    "tv/popular"
  }
  
  var parameters: [String: String]? {
    ["api_key": "bbdfe81e406333158335330da668137d",
     "page": String(page)]
  }
}
