import SwiftUI

struct SearchSection: View {
    @EnvironmentObject var modelData: ModelData
    
    @State private var emoteName: String = ""
    @State private var searchCaseSensitive: Bool = false
    @State private var searchExactMatch: Bool = false
    
    var body: some View {
        Group { 
            TextField(
                "Emote name",
                text: $emoteName
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            
            Toggle("Case Sensitive", isOn: $searchCaseSensitive)
            Toggle("Exact Match", isOn: $searchExactMatch)
            
            Button {
                Task {
                    await modelData.searchEmotes(
                        query: SevenTVAPISearchEmotesQuery(query: emoteName,
                                                           page: 1,
                                                           caseSensitive: searchCaseSensitive,
                                                           exactMatch: searchExactMatch)
                    )
                }
            } label: {
                Text("Search")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
