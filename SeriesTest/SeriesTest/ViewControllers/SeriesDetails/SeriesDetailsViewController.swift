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
    
    nameLabel.text = viewModel.serie.name
    overviewLabel.text = viewModel.serie.overview
    posterImageView.image = viewModel.serie.posterImage
    
    viewModel.fetchSimilarSeries { [weak self] in
      self?.collectionView.reloadData()
    }
  }
}

// MARK: - UICollectionViewDelegate
extension SeriesDetailsViewController: UICollectionViewDelegate {
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
    
    if let posterImage = serie.posterImage {
      cell.set(image: posterImage)
    } else if let posterPath = serie.posterPath,
                let posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + posterPath) {
      imageLoaderService.loadImage(from: posterUrl)
       .receive(on: RunLoop.main)
       .sink { [weak self] image in
         self?.viewModel.series[indexPath.row].posterImage = image
         cell.set(image: image)
       }
       .store(in: &subscriptions)
    }
    
    return cell
  }
}


