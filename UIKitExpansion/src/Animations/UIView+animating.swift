//
// Created by Arnon Keereena on 2019-08-05.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit

private var animatingKey: Int = 0

protocol Animatable {
  associatedtype View: UIView
  
  var animating: Animating<View> { get set }
}

extension Animatable where Self: UIView {
  public var animating: Animating<Self> {
    get { return objc_getAssociatedObject(self, &animatingKey) as? Animating ?? .new(self) }
    set {
      objc_setAssociatedObject(self, &animatingKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
    }
  }
}

extension UIView: Animatable {
}

public struct Animating<View: UIView> {
  
  var view: View
  
  private init(_ view: View) {
    self.view = view
  }
  
  public static func new(_ view: View) -> Animating<View> {
    return .init(view)
  }
  
  public func animate(duration: TimeInterval = 0.3,
                      delay: TimeInterval = 0,
                      options: UIView.AnimationOptions = [],
                      animations: @escaping (View?) -> Void) {
    animate(duration: duration,
            delay: delay,
            options: options,
            animations: animations,
            completion: {})
  }
  
  public func animate(duration: TimeInterval = 0.3,
                      delay: TimeInterval = 0,
                      options: UIView.AnimationOptions = [],
                      animations: @escaping (View?) -> Void,
                      completion: @escaping () -> Void = {}) {
    UIView.animate(withDuration: duration,
                   delay: delay,
                   options: options,
                   animations: { [weak view] in animations(view) },
                   completion: { _ in completion() })
  }
  
  public func springAnimate(duration: TimeInterval = 0.3,
                            delay: TimeInterval = 0,
                            damping: CGFloat = 0.75,
                            velocity: CGFloat = 0.9,
                            animations: @escaping (View?) -> Void) {
    springAnimate(duration: duration,
                  delay: delay,
                  damping: damping,
                  velocity: velocity,
                  animations: animations,
                  completion: {})
  }
  
  public func springAnimate(duration: TimeInterval = 0.3,
                            delay: TimeInterval = 0,
                            damping: CGFloat = 0.75,
                            velocity: CGFloat = 0.9,
                            animations: @escaping (View?) -> Void,
                            completion: @escaping () -> Void = {}) {
    UIView.animate(withDuration: duration,
                   delay: delay,
                   usingSpringWithDamping: damping,
                   initialSpringVelocity: velocity,
                   animations: { [weak view] in animations(view) },
                   completion: { _ in completion() })
  }
  
  
  public func wobbleFromLargest(x: CGFloat = 1, y: CGFloat = 1, endAnimations: @escaping (View?) -> Void) {
    view.animating.scale(x: x, y: y, duration: 0.1) { [weak view] in
      view?.animating.animate(duration: 0.1, delay: 0.1) {
        endAnimations($0)
      }
      view?.animating.scale(x: 1, y: 1, duration: 0.6, spring: true, damping: 0.3, velocity: 0.1)
    }
  }
}
