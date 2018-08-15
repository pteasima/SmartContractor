import Unidirectional

public typealias ContractID = String

public enum Action {
  case didSelect(contractAt: Int)
  case add(contract: Contract)
}

public typealias Contract = String
public struct State {

  public var contracts: [Contract] = ["1", "2", "3"]
  public var favorites: [Contract] = []
  public var selectedContract: Contract?
}

public func reduce<E: Effect>(state: inout State, action: Action) -> E {
  switch action {
  case let .didSelect(contractAt: index):
    state.selectedContract = state.contracts[index]
  case let .add(contract: contract):
    state.contracts.append(contract)
  }
  return .empty
}

public var store: Store<State,Action> = Store(effect: RunEffect.self, initialState: State(), reduce: reduce)
public func dispatch(_ action: Action) { store.dispatch(action) }
public var state: State { return store.state }
