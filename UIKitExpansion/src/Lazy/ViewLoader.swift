//
// Created by Arnon Keereena on 24/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public class ViewLoader<View: UIView> {
  var view: View
  
  public init(view: View) {
    self.view = view
  }
  
  public func releases() {
    onConfigureHandler = nil
    onLayoutHandler = nil
    onPostLayoutHandler = nil
  }
  
  public func load(to superview: UIView? = nil) -> View {
    if let superview = superview {
      return load {
        superview.addSubview($0)
        let layout = onLayoutHandler ?? { $0.snapEdges() }
        view.snp.makeConstraints { layout($0) }
        view.layoutIfNeeded()
      }
    } else {
      return load { _ in
        self.onLayoutHandler.flatMap { handler in
          view.snp.makeConstraints { handler($0) }
          view.layoutIfNeeded()
        }
      }
    }
  }
  
  public func load(with fn: (View) -> Void) -> View {
    defer { releases() }
    view.translatesAutoresizingMaskIntoConstraints = false
    onConfigureHandler.flatMap {
      $0(view)
    }
    fn(view)
    onPostLayoutHandler.flatMap {
      $0(view)
    }
    return view
  }
  
  public typealias OnConfigureHandler = (View) -> ()
  private var onConfigureHandler: OnConfigureHandler?
  
  @discardableResult
  public func configure(_ block: @escaping OnConfigureHandler) -> Self {
    onConfigureHandler = block
    return self
  }
  
  public typealias OnLayoutHandler = (ConstraintMaker) -> ()
  private var onLayoutHandler: OnLayoutHandler?
  
  @discardableResult
  public func layout(_ block: @escaping OnLayoutHandler) -> Self {
    onLayoutHandler = block
    return self
  }
  
  
  public typealias OnPostLayoutHandler = (View) -> ()
  private var onPostLayoutHandler: OnPostLayoutHandler?
  
  @discardableResult
  public func postLayout(_ block: @escaping OnPostLayoutHandler) -> Self {
    onPostLayoutHandler = block
    return self
  }
}
