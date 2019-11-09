//
// Created by Arnon Keereena on 28/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension Animating {
  func scale(x: CGFloat,
             y: CGFloat,
             duration: TimeInterval = 0.3,
             delay: TimeInterval = 0,
             options: UIView.AnimationOptions = [],
             spring: Bool = false,
             damping: CGFloat = 0.75,
             velocity: CGFloat = 0.9,
             completion: @escaping () -> Void = {}) {
    let animations: () -> Void = { [weak view] in
      view?.transform = CGAffineTransform(scaleX: x, y: y)
    }
    if spring {
      UIView.animate(withDuration: duration,
                     delay: delay,
                     usingSpringWithDamping: damping,
                     initialSpringVelocity: velocity,
                     options: options,
                     animations: animations,
                     completion: { _ in completion() })
    } else {
      UIView.animate(withDuration: duration,
                     delay: delay,
                     options: options,
                     animations: animations,
                     completion: { _ in completion() })
    }
  }
  
  func scale(factor: CGFloat,
             duration: TimeInterval = 0.3,
             delay: TimeInterval = 0,
             completion: @escaping () -> Void = {}) {
    scale(x: factor, y: factor, duration: duration, delay: delay, completion: completion)
  }
  
  func scale(from fromXY: CGFloat,
             to toXY: CGFloat,
             duration: TimeInterval = 0.3,
             delay: TimeInterval = 0,
             completion: @escaping () -> Void = {}) {
    view.transform = CGAffineTransform(scaleX: fromXY, y: fromXY)
    scale(factor: toXY, duration: duration, delay: delay, completion: completion)
  }
  
}
