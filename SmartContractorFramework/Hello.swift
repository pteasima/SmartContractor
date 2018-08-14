//
//  Hello.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 05/08/2018.
//

import Foundation
import Unidirectional

public enum Action { }
public let x = RunEffect<Action> { _ in print("hello") }

public let somethingElse = "just a string"
