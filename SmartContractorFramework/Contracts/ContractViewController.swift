import UIKit
import Tagged

public final class ContractViewController: BaseTableViewController {
  public var contractID: Tagged<Contract, String>? {
    return userActivity?.webpageURL?.absoluteString.split(separator: "/").last.map { Tagged(rawValue: String($0)) }
  }

  public override func viewDidLoad() {
    tableView.do {
      $0.numberOfSectionsIn { 1 }
      $0.numberOfRows { _ in 1 }
      $0.cellForRow { [unowned tableView = $0, unowned self] indexPath in
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contractInfoCell, for: indexPath)!
        cell.textLabel?.text = "Address:"
        cell.detailTextLabel?.text = self.contractID?.rawValue
        return cell
      }
    }
    super.viewDidLoad()
  }


  override public func update(state: State) {
    guard let contract: Contract = state.contracts.first(where: { $0.id == contractID}) else {
      assertionFailure(); return
    }
    title = contract.name
  }
}
