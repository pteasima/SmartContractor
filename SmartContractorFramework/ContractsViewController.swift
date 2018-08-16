//
//  ViewController.swift
//  SmartContractorIos
//
//  Created by Petr Šíma on 14/08/2018.
//

import UIKit
import Unidirectional
import Closures
import Fakery

public struct HomeScreen { public init() { } }
public struct FavoriteContractsScreen {
  var userID: String
}
//
//
//public enum Either<A, B> {
//  case left(A)
//  case right(B)
//}
//
//public protocol ViewController {
//  associatedtype Screen
//  func configure(for screen: Screen)
//}
//extension ViewController {
//
//}

public class ContractsViewController: BaseTableViewController {
  public func configure(for screen: HomeScreen) {
    didUpdateState { [unowned self] newState in
      print("home")
      self.selectedContract = newState.selectedContract
      self.contracts = newState.contracts
    }
    tableView.numberOfRows { [unowned self] _ in
      self.contracts.count
    }
    tableView.cellForRow { [unowned self] indexPath in
      print("cellForRow")
      let cell = self.tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contractCell, for: indexPath)!
      cell.textLabel?.text = self.contracts[indexPath.row]
      return cell
    }

    tableView.didSelectRowAt { indexPath in
      print("didSElect(\(indexPath)")
      dispatch(.didSelect(contractAt: indexPath.row))
    }

  }

  public func configure(for screen: FavoriteContractsScreen) {
    didUpdateState { [unowned self] newState in
      self.contracts = newState.favorites
    }
    tableView.didSelectRowAt { indexPath in
      print(indexPath)

    }
  }


  public override func viewDidLoad() {
    super.viewDidLoad()

    Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//      dispatch(.add(contract: String(describing: date)))
      dispatch(.showError(String(describing: timer.fireDate)))
    }

  }


  var contracts: [Contract] = [] {
    didSet {
      if oldValue != contracts {
        tableView.reloadData()
      }
    }
  }
  var selectedContract: Contract? {
    didSet {
      if oldValue != selectedContract {
        print("go")
        performSegue(withIdentifier: R.segue.contractsViewController.homeToContracts, sender: self)
      }
    }
  }

  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("segue")
    segue.destination.view.backgroundColor = UIColor.random()
  }
}

