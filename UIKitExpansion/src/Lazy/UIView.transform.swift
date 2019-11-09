//
// Created by Arnon Keereena on 2019-08-08.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIView {
  public func transform(to view: UIView, commonReference: UIView? = UIApplication.shared.keyWindow) -> CGAffineTransform {
    var (a, b) = (self.frame, view.frame)
    if let reference = commonReference {
      a = self.convert(self.bounds, to: reference)
      b = view.convert(view.bounds, to: reference)
    }
    let distance = b.rectCenter() - a.rectCenter()
    let scaling  = a.scaleFactor(to: b)
    return CGAffineTransform(translationX: distance.x, y: distance.y).scaledBy(x: scaling.w, y: scaling.h)
  }
  
}

