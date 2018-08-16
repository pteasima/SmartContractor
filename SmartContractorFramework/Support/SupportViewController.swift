//
//  SupportViewController.swift
//  SmartContractorFramework
//
//  Created by Petr Šíma on 16/08/2018.
//

import UIKit

public typealias ErrorID = String
public final class SupportViewController: BaseViewController {
  var context: ErrorID? {
    return userActivity?.userInfo?["errorID"] as? ErrorID
  }
  @IBOutlet var label: UILabel!
  public override func viewDidLoad() {
    super.viewDidLoad()
    label.text = context
    if context == nil {
      
    }
  }
}
