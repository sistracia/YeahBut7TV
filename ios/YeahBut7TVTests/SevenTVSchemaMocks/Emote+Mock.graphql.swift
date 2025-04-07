// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import YeahBut7TV

public class Emote: MockObject {
  public static let objectType: ApolloAPI.Object = SevenTVAPI.Objects.Emote
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Emote>>

  public struct MockFields {
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Emote {
  convenience init(
    name: String? = nil
  ) {
    self.init()
    _setScalar(name, for: \.name)
  }
}
