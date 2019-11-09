//
// Created by Arnon Keereena on 14/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import SnapKit

class Lazy<View: UIView> {
  typealias Config = (ConstraintMaker) -> Void
  typealias PreConfig = (View) -> Void
  
  class func getView<VT: UIView>(_ viewType: VT.Type) -> VT {
    if let collectionType = viewType as? UICollectionView.Type {
      let layout = UICollectionViewFlowLayout()
      layout.minimumLineSpacing = 8
      layout.minimumInteritemSpacing = 8
      return collectionType.init(frame: .zero, collectionViewLayout: layout) as! VT
    } else {
      return viewType.init(frame: .zero)
    }
  }
  
  class func getLoader<VT: UIView>(_ viewType: VT.Type) -> ViewLoader<VT> {
    return ViewLoader(view: getView(viewType))
  }
  
  class func load(to superview: UIView? = nil) -> View {
    return getLoader(View.self).load(to: superview)
  }
  
  class func load(with fn: (View) -> Void) -> View {
    return getLoader(View.self).load(with: fn)
  }
  
  class func layout(_ layout: @escaping ViewLoader<View>.OnLayoutHandler) -> ViewLoader<View> {
    return getLoader(View.self).layout(layout)
  }
  
  class func postLayout(_ postLayout: @escaping ViewLoader<View>.OnPostLayoutHandler) -> ViewLoader<View> {
    return getLoader(View.self).postLayout(postLayout)
  }
  
  class func configure(_ configure: @escaping ViewLoader<View>.OnConfigureHandler) -> ViewLoader<View> {
    return getLoader(View.self).configure(configure)
  }
}
