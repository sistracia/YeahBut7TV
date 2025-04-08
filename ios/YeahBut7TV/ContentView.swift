import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @StateObject var textObserver = TextObserver()
    
    var body: some View {
        VStack {
            TextField(
                "Emotes",
                text: $textObserver.text
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            Spacer()
        }
        .padding()
        .onChange(of: modelData.emotes) { emotes in
            debugPrint(emotes)
        }
        .task(id: textObserver.debouncedText) {
            await modelData.searchEmotes(
                query: SevenTVAPI.SearchEmotesQuery(query: textObserver.debouncedText, page: 1, sort: .none, limit: 10, filter: .none)
            )
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
