//
// Created by Arnon Keereena on 2019-08-16.
//

import UIKit

extension UIStoryboard {
  public func instantiate<T: UIViewController>(_ type: T.Type = T.self) -> T {
    guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
      fatalError()
    }
    return viewController
  }
}
