//
//  SeriesCollectionViewCell.swift
//  SeriesCollectionViewCell
//
//  Created by anduser on 30.09.21.
//

import Foundation
import UIKit
import Combine

final class SeriesCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var posterImageView: UIImageView!
  
  private var cancellable: AnyCancellable?
  private let imageLoaderService = ImageLoaderService()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancelPosterLoading()
  }
  
  func setup(with serie: SimilarSerie) {
    cancelPosterLoading()
    
    nameLabel.text = serie.name
    
    if let posterURL = serie.posterURL {
      cancellable = imageLoaderService.loadImage(from: posterURL)
        .sink { [weak self] poster in self?.show(poster: poster) }
    }
  }
}

// MARK: - ReusableView
extension SeriesCollectionViewCell: ReusableView {}

// MARK: - Private
private extension SeriesCollectionViewCell {
  
  func show(poster: UIImage?) {
    cancelPosterLoading()
    posterImageView.image = poster?.resize(to: .medium)
  }
  
  func cancelPosterLoading() {
    posterImageView.image = nil
    cancellable?.cancel()
  }
}
