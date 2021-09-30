//
//  Environment.swift
//  Environment
//
//  Created by anduser on 29.09.21.
//

import Foundation

enum Environment {
  
  case staging
}

extension Environment {
  
  static var current: Environment {
    return .staging
  }
}

extension Environment {
  
  var baseUrl: URL {
    guard
      let urlString = Bundle.main.infoDictionary?["ServerURL"] as? String,
        let url = URL(string: urlString) else {
          fatalError("ServerURL is invalid or not exists in info.plist")
        }
    return url
  }
}

