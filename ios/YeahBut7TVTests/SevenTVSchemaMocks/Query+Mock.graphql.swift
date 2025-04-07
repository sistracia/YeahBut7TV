// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import YeahBut7TV

public class Query: MockObject {
  public static let objectType: ApolloAPI.Object = SevenTVAPI.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<EmoteSearchResult>("emotes") public var emotes
  }
}

public extension Mock where O == Query {
  convenience init(
    emotes: Mock<EmoteSearchResult>? = nil
  ) {
    self.init()
    _setEntity(emotes, for: \.emotes)
  }
}
