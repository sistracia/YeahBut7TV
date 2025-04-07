// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension SevenTVAPI {
  struct Sort: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      value: String,
      order: GraphQLEnum<SortOrder>
    ) {
      __data = InputDict([
        "value": value,
        "order": order
      ])
    }

    public var value: String {
      get { __data["value"] }
      set { __data["value"] = newValue }
    }

    public var order: GraphQLEnum<SortOrder> {
      get { __data["order"] }
      set { __data["order"] = newValue }
    }
  }

}