//
// Created by Arnon Keereena on 28/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension Animating {
  func fadeIn(duration: TimeInterval = 0.2,
              delay: TimeInterval = 0,
              completion: @escaping () -> Void = {}) {
    UIView.animate(withDuration: duration, delay: delay, animations: { [weak view] in
      view?.alpha = 1
    }, completion: { _ in completion() })
  }
  
  func fadeOut(duration: TimeInterval = 0.2,
               delay: TimeInterval = 0,
               completion: @escaping () -> Void = {}) {
    UIView.animate(withDuration: duration, delay: delay, animations: { [weak view] in
      view?.alpha = 0
    }, completion: { _ in completion() })
  }
  
}
