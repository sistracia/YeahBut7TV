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
            Text("Total emotes: \(modelData.emote.emotes.count)")
        }
        .padding()
        .task(id: textObserver.debouncedText) {
            await modelData.searchEmotes(
                query: SevenTVAPISearchEmotesQuery(query: textObserver.debouncedText)
            )
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ModelData())
}
