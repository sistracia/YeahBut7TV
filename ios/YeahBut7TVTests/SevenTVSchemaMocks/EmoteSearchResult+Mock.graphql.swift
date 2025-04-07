// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import YeahBut7TV

public class EmoteSearchResult: MockObject {
  public static let objectType: ApolloAPI.Object = SevenTVAPI.Objects.EmoteSearchResult
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<EmoteSearchResult>>

  public struct MockFields {
    @Field<Int>("count") public var count
    @Field<[Emote]>("items") public var items
  }
}

public extension Mock where O == EmoteSearchResult {
  convenience init(
    count: Int? = nil,
    items: [Mock<Emote>]? = nil
  ) {
    self.init()
    _setScalar(count, for: \.count)
    _setList(items, for: \.items)
  }
}
