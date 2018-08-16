import Unidirectional

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
  case routeToFavorites
  case route(to: URL)
  case run(activity: NSUserActivity)
  case didSelect(contractAt: Int)
  case add(contract: Contract)

  case showError(String)
}

public typealias Contract = String
public struct State {
  public var contracts: [Contract] = ["1", "2", "3"]
  public var favorites: [Contract] = []
  public var selectedContract: Contract?

  public var errors: [ErrorID] = ["first"]
  //todo nonempty array
  public var activities: [NSUserActivity] = [NSUserActivity(activityType: "cz.smartcontractor.browsingHome").then {
    $0.webpageURL = URL(string: "https://smartcontractor.cz/home")
    }]
}

public func reduce<E: NavigationEffect>(state: inout State, action: Action) -> E {
  switch action {
  case .routeToFavorites:
    break
  case let .route(to: url):
    break
  case let .run(activity: activity):
    print(activity)
  case let .didSelect(contractAt: index):
    state.selectedContract = state.contracts[index]
    let activity = NSUserActivity(activityType: "cz.smartcontractor.browseContractDetail")
    activity.webpageURL = URL(string: "/contract/\(state.contracts[index])")
    
  case let .add(contract: contract):
    state.contracts.append(contract)
  case let .showError(text):
    let newActivities = [NSUserActivity(activityType: "cz.smartcontractor.error").then {
      $0.webpageURL = URL(string: "https://smartcontractor.cz/error")
      $0.userInfo?["errorID"] = text
      }]
    let navigate = E.dismiss(to: Bool.random() ? state.activities.first! : state.activities.last!, andPresent: newActivities)
    state.activities.append(contentsOf: newActivities)
    return navigate
  }
  return .empty
}

public var store: Store<State,Action> = Store(effect: RunEffect.self, initialState: State(), reduce: reduce)
public func dispatch(_ action: Action) { store.dispatch(action) }
public var state: State { return store.state }

