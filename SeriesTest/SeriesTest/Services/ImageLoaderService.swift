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
  
  private enum Constants {
    
    static let mbSize: Int = 1048576
  }
  
  private let session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = URLCache(
      memoryCapacity: 50 * Constants.mbSize,
      diskCapacity: 100 * Constants.mbSize,
      diskPath: "images")
    
    let session = URLSession(configuration: configuration)
    
    return session
  }()
  
  func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
    session.dataTaskPublisher(for: url)
      .map { data, _ -> UIImage? in UIImage(data: data) }
      .print("Image loading \(url):")
      .replaceError(with: nil)
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
  }
}
