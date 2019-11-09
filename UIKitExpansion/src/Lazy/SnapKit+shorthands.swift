//
// Created by Arnon Keereena on 2019-09-02.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import SnapKit

extension ConstraintMaker {
  
  @discardableResult
  public func snapEdges(_ value: ConstraintRelatableTarget = 0) -> [ConstraintMakerEditable] {
    func set(value: CGFloat) -> [ConstraintMakerEditable] {
      [
        top.equalTo(value),
        bottom.equalTo(-value),
        left.equalTo(value),
        right.equalTo(-value)
      ]
    }
    
    if let value = value as? CGFloat {
      return set(value: value)
    } else if let value = value as? Int {
      return set(value: CGFloat(value))
    } else {
      return [
        top.equalTo(value),
        bottom.equalTo(value),
        left.equalTo(value),
        right.equalTo(value)
      ]
    }
  }
  
  @discardableResult
  public func snapEdges(v: CGFloat, h: CGFloat, to view: UIView? = nil) -> [ConstraintMakerEditable] {
    if let view = view {
      return [
        top.equalTo(view.snp.top).offset(v),
        bottom.equalTo(view.snp.bottom).offset(-v),
        left.equalTo(view.snp.left).offset(h),
        right.equalTo(view.snp.right).offset(-h)
      ]
    } else {
      return [
        top.equalTo(v),
        bottom.equalTo(-v),
        left.equalTo(h),
        right.equalTo(-h)
      ]
    }
  }
  
  @discardableResult
  public func vEdges(equalTo v: CGFloat? = nil, view: UIView? = nil) -> [ConstraintMakerEditable] {
    if let v = v {
      if let view = view {
        return [
          top.equalTo(view.snp.top).offset(v),
          bottom.equalTo(view.snp.bottom).offset(-v)
        ]
      } else {
        return [
          top.equalTo(v),
          bottom.equalTo(-v)
        ]
      }
    } else {
      if let view = view {
        return [
          top.equalTo(view.snp.top),
          bottom.equalTo(view.snp.bottom)
        ]
      } else {
        return [
          top.equalToSuperview(),
          bottom.equalToSuperview()
        ]
      }
    }
  }
  
  @discardableResult
  public func hEdges(equalTo h: CGFloat? = nil, view: UIView? = nil) -> [ConstraintMakerEditable] {
    if let h = h {
      if let view = view {
        return [
          left.equalTo(view.snp.left).offset(h),
          right.equalTo(view.snp.right).offset(-h)
        ]
      } else {
        return [
          left.equalTo(h),
          right.equalTo(-h)
        ]
      }
    } else {
      if let view = view {
        return [
          left.equalTo(view.snp.left),
          right.equalTo(view.snp.right)
        ]
      } else {
        return [
          left.equalToSuperview(),
          right.equalToSuperview()
        ]
      }
    }
  }
  
  @discardableResult
  public func uShapeEdges(direction: UShapeDirection, equalTo offset: CGFloat? = nil) -> [ConstraintMakerEditable] {
    if let offset = offset {
      switch direction {
      case .down:
        return hEdges(equalTo: offset) + [bottom.equalTo(-offset)]
      case .up:
        return hEdges(equalTo: offset) + [top.equalTo(offset)]
      case .right:
        return vEdges(equalTo: offset) + [right.equalTo(offset)]
      case .left:
        return vEdges(equalTo: offset) + [left.equalTo(offset)]
      }
    } else {
      switch direction {
      case .down:
        return hEdges() + [bottom.equalToSuperview()]
      case .up:
        return hEdges() + [top.equalToSuperview()]
      case .right:
        return vEdges() + [right.equalToSuperview()]
      case .left:
        return vEdges() + [left.equalToSuperview()]
      }
    }
  }
  
  public enum UShapeDirection {
    case down
    case up
    case right
    case left
  }
}

extension ConstraintViewDSL {
  public func makeSnapEdges(_ value: ConstraintRelatableTarget? = nil) {
    makeConstraints { $0.snapEdges(value ?? 0) }
  }
  
  public func makeSnapEdges(v: CGFloat, h: CGFloat) {
    makeConstraints { $0.snapEdges(v: v, h: h) }
  }
  
  public func remakeSnapEdges(_ value: ConstraintRelatableTarget? = nil) {
    remakeConstraints { $0.snapEdges(value ?? 0) }
  }
  
  public func remakeSnapEdges(v: CGFloat, h: CGFloat) {
    remakeConstraints { $0.snapEdges(v: v, h: h) }
  }
  
  public func makeSnap(v: CGFloat? = nil, h: CGFloat? = nil) {
    makeConstraints {
      if let v = v {
        $0.vEdges(equalTo: v)
      }
      if let h = h {
        $0.hEdges(equalTo: h)
      }
    }
    
  }
  
  public func remakeSnap(v: CGFloat? = nil, h: CGFloat? = nil) {
    remakeConstraints {
      if let v = v {
        $0.vEdges(equalTo: v)
      }
      if let h = h {
        $0.hEdges(equalTo: h)
      }
    }
    
  }
}
