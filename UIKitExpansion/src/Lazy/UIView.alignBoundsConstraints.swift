//
// Created by Arnon Keereena on 2019-08-01.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  func alignBoundsConstraints(to view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", metrics: nil, views: ["view": self])
    )
    view.addConstraints(
      NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", metrics: nil, views: ["view": self])
    )
  }
}
