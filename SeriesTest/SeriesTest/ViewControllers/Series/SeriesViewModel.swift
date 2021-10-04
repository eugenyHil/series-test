//
//  SeriesViewModel.swift
//  SeriesViewModel
//
//  Created by anduser on 29.09.21.
//

import Foundation
import Combine

final class SeriesViewModel {
  
  private var isFetchInProgress = false
  private var page: Int = 1
  private var series: [Serie] = []
  private var filteredSeries: [Serie] = []
  
  private(set) var output = PassthroughSubject<Output, Never>()
  
  func filterContent(for searchText: String) {
    filteredSeries = series.filter {
      $0.name.lowercased().contains(searchText.lowercased())
    }
    
    output.send(.refreshTable)
  }
  
  func serie(at index: Int, isFiltering: Bool) -> Serie {
    isFiltering
    ? filteredSeries[index]
    : series[index]
  }
  
  func seriesCount(isFiltering: Bool) -> Int {
    isFiltering
    ? filteredSeries.count
    : series.count
  }
  
  func fetchNextPageIfNeeded(indexes: [Int], isFiltering: Bool) {
    if indexes.contains(where: { index in
      shouldFetchNextPage(at: index, isFiltering: isFiltering)
    }) {
      fetchPopularSeries()
    }
  }
}

// MARK: - Networking
extension SeriesViewModel {
  
  func fetchPopularSeries() {
    if isFetchInProgress {
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
            self.output.send(.refreshTable)
            self.page += 1
            
            self.isFetchInProgress = false
          }
        case .failure:
          DispatchQueue.main.async {
            // TODO (eh): error handling should be added
            self.isFetchInProgress = false
          }
        }
      }
  }
}

// MARK: - Output
extension SeriesViewModel {
  
  enum Output {
   
    case refreshTable
  }
}

// MARK: - Private
private extension SeriesViewModel {

  func shouldFetchNextPage(
    at index: Int,
    isFiltering: Bool
  ) -> Bool {
    isFiltering
    ? index >= filteredSeries.count - 1
    : index >= series.count - 1
  }
}
