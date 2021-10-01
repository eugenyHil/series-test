//
//  ImageLoaderService.swift
//  ImageLoaderService
//
//  Created by anduser on 30.09.21.
//

import Foundation
import UIKit
import Combine

final class ImageLoaderService {
  
  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
    URLSession.shared.dataTaskPublisher(for: url)
      .map { (data, response) -> UIImage? in return UIImage(data: data) }
      .catch { error in return Just(nil) }
//      .print("Image loading \(url):")
      .eraseToAnyPublisher()
    }
}
