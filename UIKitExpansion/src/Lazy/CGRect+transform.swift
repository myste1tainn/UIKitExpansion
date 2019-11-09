//
// Created by Arnon Keereena on 9/11/2019 AD.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGRect {
  public func scaleFactor(to rect: CGRect) -> (w: CGFloat, h: CGFloat) {
    let w = rect.size.width / self.size.width
    let h = rect.size.height / self.size.height
    return (w, h)
  }
  
  public func transform(to rect: CGRect) -> CGAffineTransform {
    let factor = scaleFactor(to: rect)
    return CGAffineTransform(scaleX: factor.w, y: factor.h)
  }
  
  public func rectCenter() -> CGPoint {
    CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
  }
}

extension CGPoint {
  public static func -(l: CGPoint, r: CGPoint) -> CGPoint {
    CGPoint(
      x: l.x - r.x,
      y: l.y - r.y
    )
  }
}

