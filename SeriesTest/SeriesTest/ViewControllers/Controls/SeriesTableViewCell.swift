//
//  SeriesTableViewCell.swift
//  SeriesTableViewCell
//
//  Created by anduser on 29.09.21.
//

import Foundation
import UIKit

final class SeriesTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var posterImageView: UIImageView!
  @IBOutlet private weak var ratingLabel: UILabel!
  
  func setup(with serie: Serie) {
    nameLabel.text = serie.name
    ratingLabel.text = String(serie.voteAverage)
  }
}

extension SeriesTableViewCell: ReusableView {}
