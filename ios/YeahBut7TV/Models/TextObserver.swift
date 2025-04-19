// Ref: https://stackoverflow.com/questions/66164898/swiftui-combine-debounce-textfield

import Combine
import Foundation

class TextObserver : ObservableObject {
    @Published var debouncedText = ""
    @Published var text = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        $text
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] t in
                self?.debouncedText = t
            } )
            .store(in: &subscriptions)
    }
}
