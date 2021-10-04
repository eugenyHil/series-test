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
  
  private(set) var output = PassthroughSubject<Output, Never>()
  private(set) var serie: Serie
  private(set) var series: [SimilarSerie] = []
  
  init(serie: Serie) {
    self.serie = serie
  }
}

// MARK: - Networking
extension SeriesDetailsViewModel {
  
  func fetchPoster() {
    if let posterURL = serie.posterURL {
      imageLoaderService.loadImage(from: posterURL)
        .sink { [weak self] image in
          self?.output.send(.poster(image))
        }
        .store(in: &subscriptions)
    }
  }
  
  func fetchSimilarSeries() {
    Current.webService
      .fetchSimilarSeries(serieId: serie.id, page: 1) { [weak self] in
        guard let self = self else {
          return
        }
        
        switch $0 {
        case let .success(series):
          DispatchQueue.main.async {
            self.series = series.results
            self.output.send(.refreshCollection)
          }
        case let .failure(error):
          // TODO (eh): error handling should be added
          print(error)
        }
      }
  }
}

// MARK: - Output
extension SeriesDetailsViewModel {
  
  enum Output {
   
    case refreshCollection
    case poster(UIImage?)
  }
}
