//
//  SeriesDetailsViewController.swift
//  SeriesDetailsViewController
//
//  Created by anduser on 30.09.21.
//

import Foundation
import UIKit
import Combine

final class SeriesDetailsViewController: UIViewController {
  
  @IBOutlet private weak var collectionView: UICollectionView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var overviewLabel: UILabel!
  @IBOutlet private weak var posterImageView: UIImageView!
  
  private let imageLoaderService = ImageLoaderService()
  private var subscriptions = Set<AnyCancellable>()
  
  var viewModel: SeriesDetailsViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupControls()
    setupObservers()
    
    viewModel.fetchPoster()
    viewModel.fetchSimilarSeries()
  }
}

// MARK: - UICollectionViewDataSource
extension SeriesDetailsViewController: UICollectionViewDataSource {
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    viewModel.series.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell: SeriesCollectionViewCell = collectionView.dequeueReusableCell(
      for: indexPath
    )
    let serie = viewModel.series[indexPath.row]
    cell.setup(with: serie)
    
    return cell
  }
}

// MARK: - Observers
private extension SeriesDetailsViewController {
  
  func setupObservers() {
    setupOutputObserver()
  }
  
  func setupOutputObserver() {
    viewModel.output.sink { [weak self] in
      switch $0 {
      case .refreshCollection:
        self?.collectionView.reloadData()
      case let .poster(image):
        self?.posterImageView.image = image
      }
    }
    .store(in: &subscriptions)
  }
}

// MARK: - Private
private extension SeriesDetailsViewController {
  
  func setupControls() {
    title = "Details"
    nameLabel.text = viewModel.serie.name
    overviewLabel.text = viewModel.serie.overview
  }
}
