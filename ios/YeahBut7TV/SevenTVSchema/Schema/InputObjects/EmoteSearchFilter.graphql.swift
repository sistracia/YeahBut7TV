// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension SevenTVAPI {
  struct EmoteSearchFilter: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      category: GraphQLNullable<GraphQLEnum<EmoteSearchCategory>> = nil,
      caseSensitive: GraphQLNullable<Bool> = nil,
      exactMatch: GraphQLNullable<Bool> = nil,
      ignoreTags: GraphQLNullable<Bool> = nil,
      animated: GraphQLNullable<Bool> = nil,
      zeroWidth: GraphQLNullable<Bool> = nil,
      authentic: GraphQLNullable<Bool> = nil,
      aspectRatio: GraphQLNullable<String> = nil,
      personalUse: GraphQLNullable<Bool> = nil
    ) {
      __data = InputDict([
        "category": category,
        "case_sensitive": caseSensitive,
        "exact_match": exactMatch,
        "ignore_tags": ignoreTags,
        "animated": animated,
        "zero_width": zeroWidth,
        "authentic": authentic,
        "aspect_ratio": aspectRatio,
        "personal_use": personalUse
      ])
    }

    public var category: GraphQLNullable<GraphQLEnum<EmoteSearchCategory>> {
      get { __data["category"] }
      set { __data["category"] = newValue }
    }

    public var caseSensitive: GraphQLNullable<Bool> {
      get { __data["case_sensitive"] }
      set { __data["case_sensitive"] = newValue }
    }

    public var exactMatch: GraphQLNullable<Bool> {
      get { __data["exact_match"] }
      set { __data["exact_match"] = newValue }
    }

    public var ignoreTags: GraphQLNullable<Bool> {
      get { __data["ignore_tags"] }
      set { __data["ignore_tags"] = newValue }
    }

    public var animated: GraphQLNullable<Bool> {
      get { __data["animated"] }
      set { __data["animated"] = newValue }
    }

    public var zeroWidth: GraphQLNullable<Bool> {
      get { __data["zero_width"] }
      set { __data["zero_width"] = newValue }
    }

    public var authentic: GraphQLNullable<Bool> {
      get { __data["authentic"] }
      set { __data["authentic"] = newValue }
    }

    public var aspectRatio: GraphQLNullable<String> {
      get { __data["aspect_ratio"] }
      set { __data["aspect_ratio"] = newValue }
    }

    public var personalUse: GraphQLNullable<Bool> {
      get { __data["personal_use"] }
      set { __data["personal_use"] = newValue }
    }
  }

}