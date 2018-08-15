//
//  SmartContractorFrameworkTests.swift
//  SmartContractorFrameworkTests
//
//  Created by Petr Šíma on 15/08/2018.
//

import XCTest
@testable import SmartContractorFramework

class ContractFrameworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
      self.measure {
        R.storyboard.contract().instantiateInitialViewController() as! ContractsViewController
      }
    }

}
