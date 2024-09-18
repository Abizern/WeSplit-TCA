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
        var tipType: TipType = .medium

        var grandTotal: Double {
            return checkAmount * tipType.scaleFactor
        }
        var totalPerPerson: Double {
            return grandTotal / Double(numberOfPeople)
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}


struct WeSplitView: View {
    @Bindable var store: StoreOf<WeSplitFeature>

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $store.checkAmount, format: .currency(code: "GBP")
                    )
                    .keyboardType((.decimalPad))
                    
                    PartySizePickerView(partySize: $store.numberOfPeople)
                }
                
                Section("How much do you want to tip?") {
                    TipPicker(tip: $store.tipType)
                }
                
                Section("Total Amount") {
                    Text(store.grandTotal, format: .currency(code: "GBP"))
                }
                
                Section("Amount per person") {
                    Text(store.totalPerPerson, format: .currency(code: "GBP"))
                }
            }
            .navigationTitle("We Split")
        }
    }
}

#Preview {
    WeSplitView(
        store: Store( initialState: WeSplitFeature.State()) {
            WeSplitFeature()
        }
    )
}
