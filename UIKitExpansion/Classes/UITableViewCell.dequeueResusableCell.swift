//
// Created by Arnon Keereena on 2019-08-16.
//

import UIKit
import SwiftExpansion

extension UITableView {
  public func dequeueReusableCell<T: UITableViewCell>(ofType cellType: T.Type = T.self, at indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseID,
                                         for: indexPath) as? T else {
      fatalError()
    }
    return cell
  }
}
