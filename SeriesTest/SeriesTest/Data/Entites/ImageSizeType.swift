//
//  ImageSizeType.swift
//  ImageSizeType
//
//  Created by anduser on 4.10.21.
//

import UIKit

enum ImageSizeType {
  
  case small
  case medium
}

// MARK: - Getters
extension ImageSizeType {
  
  var size: CGSize {
    switch self {
    case .small:
      return CGSize(width: 50, height: 64)
    case .medium:
      return CGSize(width: 100, height: 128)
    }
  }
}
