//
//  PosterPresentable.swift
//  PosterPresentable
//
//  Created by anduser on 3.10.21.
//

import Foundation

protocol PosterPresentable {
  
  var posterPath: String? { get }
}

extension PosterPresentable {
  
  var posterURL: URL? {
    guard let posterPath = posterPath,
          let resourceString = Bundle.main.infoDictionary?["ResourcesURL"] as? String else {
            return nil
    }
    
    return URL(string: resourceString + posterPath)
  }
}
