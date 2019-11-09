//
// Created by Arnon Keereena on 28/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension Animating {
  func slideIn(fromRelativeX x: CGFloat,
               y: CGFloat,
               duration: TimeInterval = 0.4,
               delay: TimeInterval = 0,
               spring: Bool = false,
               damping: CGFloat = 0.75,
               velocity: CGFloat = 0.9,
               options: UIView.AnimationOptions = [],
               completion: @escaping () -> Void = {}) {
    let originalTransform = view.transform
    view.transform = CGAffineTransform(translationX: x, y: y)
    let animations: (View?) -> Void = { view in view?.transform = originalTransform }
    if spring {
      springAnimate(duration: duration,
                    delay: delay,
                    damping: damping,
                    velocity: velocity,
                    animations: animations,
                    completion: completion)
    } else {
      animate(duration: duration,
              delay: delay,
              options: options,
              animations: animations,
              completion: completion)
    }
  }
  
  func slideOut(direction: Direction = .left,
                duration: TimeInterval = 0.4,
                delay: TimeInterval = 0,
                spring: Bool = false,
                damping: CGFloat = 0.75,
                velocity: CGFloat = 0.9,
                options: UIView.AnimationOptions = [],
                completion: @escaping () -> Void = {}) {
    let order = xy(direction: direction)
    let animations = { [weak view] in
      switch direction {
      case .up: view?.transform = .init(translationX: order.x, y: -order.y)
      case .down: view?.transform = .init(translationX: order.x, y: order.y)
      case .left: view?.transform = .init(translationX: -order.x, y: order.y)
      case .right: view?.transform = .init(translationX: order.x, y: order.y)
      }
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
  
  private func xy(direction: Direction) -> (x: CGFloat, y: CGFloat) {
    switch direction {
    case .up, .down: return (0, view.bounds.size.height)
    case .left, .right: return (view.bounds.size.width, 0)
    }
  }
}
