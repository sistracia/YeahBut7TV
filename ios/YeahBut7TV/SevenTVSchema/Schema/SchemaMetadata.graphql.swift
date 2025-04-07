// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public protocol SevenTVAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SevenTVAPI.SchemaMetadata {}

public protocol SevenTVAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SevenTVAPI.SchemaMetadata {}

public protocol SevenTVAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SevenTVAPI.SchemaMetadata {}

public protocol SevenTVAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SevenTVAPI.SchemaMetadata {}

public extension SevenTVAPI {
  typealias SelectionSet = SevenTVAPI_SelectionSet

  typealias InlineFragment = SevenTVAPI_InlineFragment

  typealias MutableSelectionSet = SevenTVAPI_MutableSelectionSet

  typealias MutableInlineFragment = SevenTVAPI_MutableInlineFragment

  enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    public static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      switch typename {
      case "Emote": return SevenTVAPI.Objects.Emote
      case "EmoteSearchResult": return SevenTVAPI.Objects.EmoteSearchResult
      case "Query": return SevenTVAPI.Objects.Query
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}