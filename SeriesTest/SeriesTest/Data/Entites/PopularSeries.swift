//
//  PopularSeries.swift
//  PopularSeries
//
//  Created by anduser on 29.09.21.
//

import Foundation
import UIKit

struct PopularSeries: Codable {
  
  let page: Int
  let results: [Serie]
}

struct Serie: Codable {
 
  let id: Int
  let name: String
  let posterPath: String?
  let voteAverage: Double
  let overview: String
  var posterImage: UIImage?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
    case overview
  }
}
