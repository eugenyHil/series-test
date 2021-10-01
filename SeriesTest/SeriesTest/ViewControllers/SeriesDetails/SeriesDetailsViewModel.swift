//
//  SeriesDetailsViewModel.swift
//  SeriesDetailsViewModel
//
//  Created by anduser on 30.09.21.
//

import Foundation
import Combine
import UIKit

final class SeriesDetailsViewModel {
  
  private var subscriptions = Set<AnyCancellable>()
  private let imageLoaderService = ImageLoaderService()
  
  let serie: Serie
  var series: [SimilarSerie] = []
  
  init(serie: Serie) {
    self.serie = serie
  }
}

// MARK: - Networking
extension SeriesDetailsViewModel {
  
  func fetchSimilarSeries(refreshCompletion: @escaping () -> Void) {
    Current.webService
      .fetchSimilarSeries(serieId: serie.id, page: 1) { [weak self] in
        guard let self = self else {
          return
        }
        
        switch $0 {
        case let .success(series):
          print(series)
          DispatchQueue.main.async {
            self.series += series.results
            refreshCompletion()
          }
        case let .failure(error):
          print(error)
        }
      }
  }
}
