//
//  BaseViewController.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 15/08/2018.
//

import UIKit
import Unidirectional
import ObjectiveC




public class BaseViewController: UIViewController {

}

public class BaseTableViewController: UITableViewController, Observer {

  public func update(state: State) {
    didUpdateState(state)
  }

  public typealias State = SmartContractorFramework.State

  func didUpdateState(_ handler: @escaping (State) -> ()) {
    didUpdateState = handler
  }
  private var didUpdateState: (State) -> () = { _ in
    print("Unhandled state update in \(self)" )
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    update(state: state)
    store.addObserver(self)
  }


}
