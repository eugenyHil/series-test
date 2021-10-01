//
//  UIStoryboard.swift
//  UIStoryboard
//
//  Created by anduser on 30.09.21.
//

import UIKit

protocol StoryboardIdentifiable {
  
  static var identifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
  
  static var identifier: String {
    String(describing: self)
  }
}

extension UIViewController: StoryboardIdentifiable { }

extension UIStoryboard {
    
  enum Storyboard: String {
    
    case main = "Main"
    
    var filename: String {
      rawValue
    }
  }
  
  static func storyboard(
    storyboard: Storyboard,
    bundle: Bundle? = nil
  ) -> UIStoryboard {
    UIStoryboard(name: storyboard.filename, bundle: bundle)
  }
  
  func instantiateViewController<T: UIViewController>() -> T {
    guard let viewController = instantiateViewController(withIdentifier: T.identifier) as? T else {
      fatalError("Couldn't instantiate view controller with identifier \(T.identifier) ")
    }
    
    return viewController
  }
}
