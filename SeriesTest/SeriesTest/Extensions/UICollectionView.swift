//
//  UICollectionView.swift
//  UICollectionView
//
//  Created by anduser on 30.09.21.
//

import UIKit

extension UICollectionView {
  
  func dequeueReusableCell<T: UICollectionViewCell>(
    for indexPath: IndexPath
  ) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(
      withReuseIdentifier: T.reuseIdentifier,
      for: indexPath as IndexPath
    ) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    
    return cell
  }
}
