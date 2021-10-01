//
//  SeriesCollectionViewCell.swift
//  SeriesCollectionViewCell
//
//  Created by anduser on 30.09.21.
//

import Foundation
import UIKit

final class SeriesCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var posterImageView: UIImageView!
  
  func setup(with serie: SimilarSerie) {
    nameLabel.text = serie.name
  }
  
  func set(image: UIImage?) {
    posterImageView.image = image
  }
}

extension SeriesCollectionViewCell: ReusableView {}
