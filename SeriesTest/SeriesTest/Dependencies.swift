//
//  Dependencies.swift
//  Dependencies
//
//  Created by anduser on 29.09.21.
//

import Foundation

struct Dependencies {
  
  var webService: WebService
  
  init() {
    webService = WebServiceImp()
  }
}

var Current = Dependencies()
