//
//  Extensions.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 15/08/2018.
//

import UIKit
import Closures

public extension UIColor {
  public static func random() -> UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
  }
}

public extension UITableView {
  func set<Item>(items: [Item], cellForRow cell: @escaping (IndexPath, Item) -> UITableViewCell) {
    numberOfSectionsIn { 1 }
    numberOfRows { _ in items.count }
    cellForRow { cell($0, items[$0.row]) }
    reloadData()
  }
}
