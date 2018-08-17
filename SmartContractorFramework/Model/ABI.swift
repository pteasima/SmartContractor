import Tagged

public struct Contract: Equatable {
  public let id: Tagged<Contract, String>
  public var name: String
  public let functions: [SolidityFunction]
}

public struct SolidityFunction: Equatable {
  public struct Param: Equatable {
    public let name: String
    public let type: SolidityType
  }

  public let name: String
  public let params: [Param]
}

public enum SolidityType: String, Equatable {
  case int
  case string
}
