import Unidirectional
import Tagged

//enum Route {
//  case error
//  case home
//  case favorites(String)
//  case detail(ContractID)
//
//  var url: URL {
//    switch self {
//    case .error:
//      return URL(string: "/error")!
//    case .home:
//      return URL(string: "/home")!
//    case let .favorites(userID):
//      return URL(string: "/users/\(userID)/favorites")!
//    case let .detail(contractID):
//      return URL(string: "/contracts/\(contractID)")!
//    }
//  }
//}
//
//
//var activities: [NSUserActivity] = []
//func push(_ activity: NSUserActivity) {
//  activities.append(activity)
//}
//
//func pop(to: NSUserActivity? = nil) {
//  UIApplication.shared.keyWindow?.rootViewController
//}
//
//
//


public typealias ContractID = String

public enum Action {
  case noAction
  case didSelect(contractAt: Int)

  case showError(String)
}

public struct Contract: Equatable {
  public let id: Tagged<Contract, String>
  public var name: String

}
public struct State {
  public var contracts: [Contract] = [Contract(id: .init(rawValue: UUID().uuidString), name: "foo")]
  public var favorites: [Contract] = []

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

