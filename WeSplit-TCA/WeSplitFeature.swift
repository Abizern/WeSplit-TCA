//
//  Public Domain --- See License file for details
//
import ComposableArchitecture
import SwiftUI

@Reducer
struct WeSplitFeature {
    @ObservableState
    struct State: Equatable {
        var checkAmount = 0.0
        var numberOfPeople = 2
        var tipPercentage = 20
        var grandTotal: Double {
            let tipIncrement = 1 + Double(tipPercentage) / 100
            return checkAmount * tipIncrement
        }
        var totalPerPerson: Double {
            return grandTotal / Double(numberOfPeople)
        }
    }
}


struct WeSplitView: View {
    let store: StoreOf<WeSplitFeature>

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    WeSplitView(
        store: Store( initialState: WeSplitFeature.State()) {
            WeSplitFeature()
        }
    )
}
