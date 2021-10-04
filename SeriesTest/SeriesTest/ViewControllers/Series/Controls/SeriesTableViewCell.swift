//
//  SeriesTableViewCell.swift
//  SeriesTableViewCell
//
//  Created by anduser on 29.09.21.
//

import Foundation
import UIKit
import Combine

final class SeriesTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var ratingLabel: UILabel!
  
  private var cancellable: AnyCancellable?
  private let imageLoaderService = ImageLoaderService()
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cancelPosterLoading()
  }
  
  func setup(with serie: Serie) {
    cancelPosterLoading()
    
    nameLabel.text = serie.name
    ratingLabel.text = String(serie.voteAverage)
    
    if let posterURL = serie.posterURL {
      cancellable = imageLoaderService.loadImage(from: posterURL)
        .sink { [weak self] poster in self?.show(poster: poster) }
    }
  }
}

// MARK: - ReusableView
extension SeriesTableViewCell: ReusableView {}

// MARK: - Private
private extension SeriesTableViewCell {
  
  func show(poster: UIImage?) {
    cancelPosterLoading()
    posterImageView.image = poster?.resize(to: .small)
  }
  
  func cancelPosterLoading() {
    posterImageView.image = nil
    cancellable?.cancel()
  }
}
