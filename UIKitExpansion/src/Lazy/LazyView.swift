//
// Created by Arnon Keereena on 14/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import SnapKit

public class Lazy<View: UIView> {
  public typealias Config = (ConstraintMaker) -> Void
  public typealias PreConfig = (View) -> Void
  
  public class func getView<VT: UIView>(_ viewType: VT.Type) -> VT {
    if let collectionType = viewType as? UICollectionView.Type {
      let layout = UICollectionViewFlowLayout()
      layout.minimumLineSpacing = 8
      layout.minimumInteritemSpacing = 8
      return collectionType.init(frame: .zero, collectionViewLayout: layout) as! VT
    } else {
      return viewType.init(frame: .zero)
    }
  }
  
  public class func getLoader<VT: UIView>(_ viewType: VT.Type) -> ViewLoader<VT> {
    ViewLoader(view: getView(viewType))
  }
  
  public class func load(to superview: UIView? = nil) -> View {
    getLoader(View.self).load(to: superview)
  }
  
  public class func load(with fn: (View) -> Void) -> View {
    getLoader(View.self).load(with: fn)
  }
  
  public class func layout(_ layout: @escaping ViewLoader<View>.OnLayoutHandler) -> ViewLoader<View> {
    getLoader(View.self).layout(layout)
  }
  
  public class func layoutWithSelf(_ layout: @escaping ViewLoader<View>.OnLayoutWithSelfHandler) -> ViewLoader<View> {
    getLoader(View.self).layoutWithSelf(layout)
  }
  
  public class func postLayout(_ postLayout: @escaping ViewLoader<View>.OnPostLayoutHandler) -> ViewLoader<View> {
    getLoader(View.self).postLayout(postLayout)
  }
  
  public class func configure(_ configure: @escaping ViewLoader<View>.OnConfigureHandler) -> ViewLoader<View> {
    getLoader(View.self).configure(configure)
  }
}
