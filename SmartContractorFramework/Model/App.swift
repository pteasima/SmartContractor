import Unidirectional
import Tagged

public typealias ContractID = String

public enum Action {
  case noAction
  case didSelect(contractAt: Int)
//  case paramValueDidChange(toString: String)
//  case paramValueDidChange(toInt: Int)
  case showError(String)
}

public struct State {
  public var contracts: [Contract] = [
    Contract(id: .init(rawValue: UUID().uuidString), name: "MyContract", functions: [
      SolidityFunction(name: "helloWorld", params: [
        SolidityFunction.Param(name: "foo", type: .string),
        SolidityFunction.Param(name: "bar", type: .int),
        ])
    ])
  ]
  public var favorites: [Contract] = []
  public var contractDetailActivity: NSUserActivity? {
    didSet {
      let activity = contractDetailActivity
      contractDetail = contracts.first(where: { $0.id == activity?.webpageURL?.absoluteString.split(separator:"/").last.map { Tagged(rawValue: String($0))} })
    }
  }
  public var contractDetail: Contract?
  public var functionDetail: (NSUserActivity, SolidityFunction)?
  public var editedParamIndex: Int?


  public var errors: [ErrorID] = ["first"]
  //todo nonempty array
  public var activities: [NSUserActivity] = [NSUserActivity(activityType: "cz.smartcontractor.browsingHome").then {
    $0.webpageURL = URL(string: "https://smartcontractor.cz/home")
    }]
}

public func reduce<E: NavigationEffect>(state: inout State, action: Action) -> E where E.Action == Action {
  switch action {
  case .noAction: break
  case let .didSelect(contractAt: index):
    break
//    let activity = NSUserActivity(activityType: "cz.smartcontractor.browseContractDetail")
//    activity.webpageURL = URL(string: "/contract/\(state.contracts[index])")
  case let .showError(text):
    let errorActivity = NSUserActivity(activityType: "cz.smartcontractor.error").then {
      $0.webpageURL = URL(string: "https://smartcontractor.cz/error")
      $0.userInfo?["errorID"] = text
      }
    let navigate = E.dismiss(to: state.activities.first!, andPresent: errorActivity, animated: true) { .noAction }
    state.activities.append(errorActivity)
    return navigate
  }
  return .empty
}

public var store: Store<State,Action> = Store(effect: RunEffect.self, initialState: State(), reduce: reduce)
public func dispatch(_ action: Action) { store.dispatch(action) }
public var state: State { return store.state }

