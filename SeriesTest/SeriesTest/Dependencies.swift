//
//  Dependencies.swift
//  Dependencies
//
//  Created by anduser on 29.09.21.
//

import Foundation

struct Dependencies {
  
  var webService: WebServiceProtocol
  
  init() {
    webService = WebService()
  }
}

var Current = Dependencies()
