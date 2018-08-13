//
//  Hello.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 05/08/2018.
//

import Foundation
import Unidirectional

enum Action { }
let x = RunEffect<Action> { _ in print("hello") }
