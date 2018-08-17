import UIKit
import Tagged

public final class ContractViewController: BaseTableViewController {
  public var contractID: Tagged<Contract, String>? {
    return userActivity?.webpageURL?.absoluteString.split(separator: "/").last.map { Tagged(rawValue: String($0)) }
  }

  public override func viewDidLoad() {
    tableView.do {

      enum Section: Int, CaseIterable {
        case contractInfo
        case functions
      }

      $0.numberOfSectionsIn { Section.allCases.count }
      $0.numberOfRows { [unowned self] in
        switch Section(rawValue: $0)! {
        case .contractInfo: return 1
        case .functions: return self.contract?.functions.count ?? 0
        }
      }
      $0.cellForRow { [unowned tableView = $0, unowned self] indexPath in
        switch Section(rawValue: indexPath.section)! {
        case .contractInfo:
          let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contractInfoCell, for: indexPath)!
          cell.textLabel?.text = "Address:"
          cell.detailTextLabel?.text = self.contractID?.rawValue
          return cell
        case .functions:
          let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contractFunctionCell, for: indexPath)!
          let function = self.contract!.functions[indexPath.row]
          cell.textLabel?.text = function.pretty()
          return cell
        }

      }
    }
    super.viewDidLoad()
  }

  var contract: Contract?
  override public func update(state: State) {
    guard let contract = state.contracts.first(where: { $0.id == contractID}) else {
      assertionFailure(); return
    }
    self.contract = contract
    title = contract.name
  }
}
