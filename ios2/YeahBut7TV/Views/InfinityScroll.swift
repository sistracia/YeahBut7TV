import SwiftUI

struct InfinityScroll: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        Text("Load More")
            .frame(maxWidth: .infinity, alignment: .center)
            .onAppear {
                Task {
                    var query = modelData.lastQuery
                    query.page = query.page + 1
                    await modelData.searchEmotes(query: query)
                }
            }
    }
}
