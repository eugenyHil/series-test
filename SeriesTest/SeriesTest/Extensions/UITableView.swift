//
//  UITableView.swift
//  UITableView
//
//  Created by anduser on 29.09.21.
//

import Foundation
import UIKit

protocol ReusableView {}

extension ReusableView where Self: UIView {
    
  static var reuseIdentifier: String {
    String(describing: self)
  }
}

extension UITableView {
  
  func dequeueReusableCell<T: UITableViewCell>(
    for indexPath: IndexPath
  ) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(
      withIdentifier: T.reuseIdentifier,
      for: indexPath as IndexPath
    ) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
    }
    
    return cell
  }
}
