//
//  ViewController.swift
//  SmartContractorIos
//
//  Created by Petr Šíma on 14/08/2018.
//

import UIKit

public final class ContractViewController: BaseViewController, UITableViewDataSource {

  public override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}

