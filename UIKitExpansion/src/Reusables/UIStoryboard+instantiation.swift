//
// Created by Arnon Keereena on 2019-08-16.
//

import UIKit
import SwiftExpansion

extension UIStoryboard {
  public func instantiate<T: Reusable>(_ type: T.Type = T.self) -> T {
    guard let viewController = instantiateViewController(withIdentifier: type.reuseID) as? T else {
      fatalError()
    }
    return viewController
  }
}
