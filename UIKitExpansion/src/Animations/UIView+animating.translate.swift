//
// Created by Arnon Keereena on 28/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

extension Animating {
  public func translateToOriginFromRelative(x: CGFloat = 0.0,
                                            y: CGFloat = 0.0,
                                            duration: TimeInterval = 0.4,
                                            delay: TimeInterval = 0.0,
                                            spring: Bool = false,
                                            damping: CGFloat = 0.75,
                                            velocity: CGFloat = 0.9,
                                            animated: Bool = true,
                                            completion: @escaping () -> Void = {}) {
    let original = view.transform
    view.transform = CGAffineTransform(translationX: x, y: y)
    if animated {
      if spring {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .curveEaseInOut,
                       animations: { [weak view] in
                         view?.transform = original
                       }, completion: { _ in completion() })
      } else {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: { [weak view] in
                         view?.transform = original
                       }, completion: { _ in completion() })
      }
    } else {
    
    }
  }
  
  public func translate(x: CGFloat = 0.0,
                        y: CGFloat = 0.0,
                        duration: TimeInterval = 0.4,
                        delay: TimeInterval = 0.0,
                        spring: Bool = false,
                        damping: CGFloat = 0.75,
                        velocity: CGFloat = 0.9,
                        animated: Bool = true,
                        completion: @escaping () -> Void = {}) {
    let animations: () -> Void = { [weak view] in
      view?.transform = CGAffineTransform(translationX: x, y: y)
    }
    if animated {
      if spring {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: { _ in completion() })
      } else {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: .curveEaseInOut,
                       animations: animations,
                       completion: { _ in completion() })
      }
    } else {
      animations()
      completion()
    }
  }
}
