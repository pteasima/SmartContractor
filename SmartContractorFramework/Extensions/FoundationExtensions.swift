//
//  FoundationExtensions.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 18/08/2018.
//

import Foundation

public extension Collection {
  public subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
