//
//  FunctionalExtensions.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 18/08/2018.
//

import Foundation

// I know this has a different name in FP, but `just` is just right for my usecase ;)
// This can be used to consicely retreive values from a switch or if-else. You still need returns inside that closure but you get compiler goodies. Its an equivalent of `{ /*code*/ }()`, but doesnt require the trailing `()`
public func just<Value>(_ value: () -> (Value)) -> Value {
  return value()
}
