//
//  SeriesViewModel.swift
//  SeriesViewModel
//
//  Created by anduser on 29.09.21.
//

import Foundation

final class SeriesViewModel {
  
  var isFetchInProgress = false
  var series: [Serie] = []
  var filteredSeries: [Serie] = []
  var page: Int = 1
  
  func filterContentForSearchText(
    _ searchText: String,
    completion: () -> Void
  ) {
    filteredSeries = series.filter {
      $0.name.lowercased().contains(searchText.lowercased())
    }
    
    completion()
  }
  
  func fetchPopularSeries(refreshCompletion: @escaping () -> Void) {
    guard !isFetchInProgress else {
      return
    }
      
    isFetchInProgress = true
    
    Current.webService
      .fetchPopularSeries(page: page) { [weak self] in
        guard let self = self else {
          return
        }
        
        switch $0 {
        case let .success(series):
          DispatchQueue.main.async {
            self.series += series.results
            refreshCompletion()
            self.page += 1
            
            self.isFetchInProgress = false
          }
        case .failure:
          DispatchQueue.main.async {
            self.isFetchInProgress = false
          }
        }
      }
  }
}
