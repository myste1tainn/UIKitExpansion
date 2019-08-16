//
// Created by Arnon Keereena on 2019-08-16.
//

import UIKit
import SwiftExpansion

extension UICollectionView {
  public func dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseID,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
}
