//
//  ReusableView.swift
//  ReusableView
//
//  Created by anduser on 30.09.21.
//

import UIKit

protocol ReusableView {}

extension ReusableView where Self: UIView {
  
  static var reuseIdentifier: String {
    String(describing: self)
  }
}
