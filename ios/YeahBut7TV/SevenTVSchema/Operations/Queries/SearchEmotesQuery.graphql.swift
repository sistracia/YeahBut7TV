// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public extension SevenTVAPI {
  class SearchEmotesQuery: GraphQLQuery {
    public static let operationName: String = "SearchEmotes"
    public static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query SearchEmotes($query: String!, $page: Int, $sort: Sort, $limit: Int, $filter: EmoteSearchFilter) { emotes(query: $query, page: $page, sort: $sort, limit: $limit, filter: $filter) { __typename count items { __typename name } } }"#
      ))

    public var query: String
    public var page: GraphQLNullable<Int>
    public var sort: GraphQLNullable<Sort>
    public var limit: GraphQLNullable<Int>
    public var filter: GraphQLNullable<EmoteSearchFilter>

    public init(
      query: String,
      page: GraphQLNullable<Int>,
      sort: GraphQLNullable<Sort>,
      limit: GraphQLNullable<Int>,
      filter: GraphQLNullable<EmoteSearchFilter>
    ) {
      self.query = query
      self.page = page
      self.sort = sort
      self.limit = limit
      self.filter = filter
    }

    public var __variables: Variables? { [
      "query": query,
      "page": page,
      "sort": sort,
      "limit": limit,
      "filter": filter
    ] }

    public struct Data: SevenTVAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: any ApolloAPI.ParentType { SevenTVAPI.Objects.Query }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("emotes", Emotes.self, arguments: [
          "query": .variable("query"),
          "page": .variable("page"),
          "sort": .variable("sort"),
          "limit": .variable("limit"),
          "filter": .variable("filter")
        ]),
      ] }

      public var emotes: Emotes { __data["emotes"] }

      /// Emotes
      ///
      /// Parent Type: `EmoteSearchResult`
      public struct Emotes: SevenTVAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: any ApolloAPI.ParentType { SevenTVAPI.Objects.EmoteSearchResult }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("count", Int.self),
          .field("items", [Item].self),
        ] }

        public var count: Int { __data["count"] }
        public var items: [Item] { __data["items"] }

        /// Emotes.Item
        ///
        /// Parent Type: `Emote`
        public struct Item: SevenTVAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: any ApolloAPI.ParentType { SevenTVAPI.Objects.Emote }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("name", String.self),
          ] }

          public var name: String { __data["name"] }
        }
      }
    }
  }

}