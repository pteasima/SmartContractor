import UIKit
import Then
import Tagged


public typealias FunctionDetailContext = (
  contractID: Tagged<Contract, String>,
  index: Int
)
public typealias FunctionInvocationContext = (FunctionDetailContext, Int)

public final class FunctionDetailViewController: BaseTableViewController {

  public var functionIndex: Int? {
    return 0 // todo
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
  }

  override public func update(state: State) {
//    guard let contract = state.contracts.first(where: { $0.id == contractID }),
//      let functionIndex = functionIndex,
//      let function = contract.functions[safe: functionIndex]
//      else {
//        assertionFailure(); return
//    }
//
//    title = function.name
//    tableView.set(items: function.params) { [unowned tableView = self.tableView!] indexPath, param in
//      let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.stringInputCell, for: indexPath)!
//
//      cell.label.text = param.name
//      param.render(into: cell.textField)
//      cell.textField.onChange { dispatch(.paramChanged(param)) }
//      return cell
//    }
  }
}
