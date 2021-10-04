//
//  SimilarSeries.swift
//  SimilarSeries
//
//  Created by anduser on 30.09.21.
//

import Foundation
import UIKit

struct SimilarSeries: Codable {
  
  let page: Int
  let results: [SimilarSerie]
}

struct SimilarSerie: Codable {

  let id: Int
  let name: String
  let posterPath: String?
}

// MARK: - PosterPresentable
extension SimilarSerie: PosterPresentable {}
