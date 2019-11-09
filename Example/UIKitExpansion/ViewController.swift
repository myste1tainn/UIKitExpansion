//
//  ViewController.swift
//  UIKitExpansion
//
//  Created by myste1tainn on 08/16/2019.
//  Copyright (c) 2019 myste1tainn. All rights reserved.
//

import UIKit
import UIKitExpansion
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  lazy var helloLabel = Lazy<UILabel>
    .layout {
      $0.uShapeEdges(direction: .up)
      $0.height.equalTo(100)
    }
    .configure {
      $0.textColor = .green
      $0.textAlignment = .center
    }
    .load(to: view)
  
  lazy var listTableView = Lazy<UITableView>
    .layout {
      $0.uShapeEdges(direction: .down)
      $0.top.equalTo(self.helloLabel.snp.bottom)
    }
    .configure { $0.backgroundColor = .lightGray }
    .load(to: view)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    animateIn()
  }
  
  private func animateIn() {
    helloLabel.animating.slideIn(fromRelativeX: 0, y: -100, delay: 0.3)
    listTableView.animating.slideIn(fromRelativeX: -375, y: 0, delay: 0.3)
  }
  
  private func bind() {
    helloLabel.text = "Hello world!"
    listTableView.tableFooterView = UIView()
    listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    listTableView.animating.setAnimateInCells()
    let strings = Driver.just(
      [
        "Hello world!",
        "Hello Jack",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane",
        "Hello Jane"
      ]
    )
    
    strings.delay(.milliseconds(400)).drive(
      listTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)
    ) { i, model, cell in
      cell.textLabel?.text = model
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

