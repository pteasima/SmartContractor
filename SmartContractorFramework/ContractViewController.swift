//
//  ViewController.swift
//  SmartContractorIos
//
//  Created by Petr Šíma on 14/08/2018.
//

import UIKit

public final class ContractViewController: UIViewController {

  public static func instantiate() {
    print(UIStoryboard(name: "Contract", bundle: Bundle(for: ContractViewController.self)))
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }


}

