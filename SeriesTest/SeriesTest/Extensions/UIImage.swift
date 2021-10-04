//
//  UIImage.swift
//  UIImage
//
//  Created by anduser on 3.10.21.
//

import UIKit

extension UIImage {
  
  func resize(to type: ImageSizeType) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(type.size, false, 0)
    
    draw(in: CGRect(origin: .zero, size: type.size))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    return resizedImage
  }
}
