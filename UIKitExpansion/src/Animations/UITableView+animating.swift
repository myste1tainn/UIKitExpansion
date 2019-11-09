//
// Created by Arnon Keereena on 18/9/2019 AD.
// Copyright (c) 2019 Arnon Keereena. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


extension Animating where View: UITableView {
  public func setAnimateInCells(_ animations: @escaping UITableView.CellAnimation = UITableView.cellAnimation) -> Disposable {
    let animator = Animator(delayFactor: 0.025)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      animator.delayFactor = 0
    }
    return view.rx.willDisplayCell.subscribe(onNext: { animator.animations($0, $1) })
  }
}

extension Animating where View: UICollectionView {
  public func setAnimateInCells(_ animations: @escaping UITableView.CellAnimation = UITableView.cellAnimation) -> Disposable {
    let animator = Animator(delayFactor: 0.005)
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      animator.delayFactor = 0
    }
    return view.rx.willDisplayCell.subscribe(onNext: { animator.animations($0, $1) })
  }
}

class Animator {
  var delayFactor: Double
  
  init(delayFactor: Double) {
    self.delayFactor = delayFactor
  }
  
  typealias Animation = (UIView, IndexPath) -> Void
  lazy var animations: Animation = {
    { cell, i in
      let delay = self.delayFactor * Double(i.row + i.section)
      cell.alpha = 0
      cell.animating.fadeIn(delay: delay)
      cell.animating.translateToOriginFromRelative(x: 0,
                                                   y: -100,
                                                   duration: 1,
                                                   delay: delay,
                                                   spring: true,
                                                   damping: 0.5,
                                                   velocity: 0.5)
    }
  }()
}

extension UITableView {
  public typealias CellAnimation = (UITableViewCell, IndexPath) -> Void
  public static var cellAnimation: CellAnimation = { cell, indexPath in
    let delay = 0.025 * Double(indexPath.row + indexPath.section)
    cell.alpha = 0
    cell.animating.fadeIn(delay: delay)
    cell.animating.translateToOriginFromRelative(x: 0,
                                                 y: -100,
                                                 duration: 1,
                                                 delay: delay,
                                                 spring: true,
                                                 damping: 0.5,
                                                 velocity: 0.5)
  }
  
  public typealias ViewAnimation = (UIView, Int) -> Void
  public static var viewAnimation: ViewAnimation = { cell, section in
    let delay = 0.025 * Double(section)
    cell.alpha = 0
    cell.animating.fadeIn(delay: delay)
    cell.animating.translateToOriginFromRelative(x: 0,
                                                 y: -100,
                                                 duration: 1,
                                                 delay: delay,
                                                 spring: true,
                                                 damping: 0.5,
                                                 velocity: 0.5)
  }
}
