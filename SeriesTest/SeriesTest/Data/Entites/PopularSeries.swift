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
}

// MARK: - PosterPresentable
extension Serie: PosterPresentable {}
