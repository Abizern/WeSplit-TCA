//
//  Public Domain --- See License file for details
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct WeSplit {
    @ObservableState
    struct State: Equatable {
        var checkAmount: Double = 0.0
        var numberOfPeople: Int = 2
        var tipType: TipType = .medium
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
    @Bindable var store: StoreOf<WeSplit>
    @Dependency(\.locale) var locale

    private var grandTotal: Double {
        return store.checkAmount * store.tipType.scaleFactor
    }

    private var totalPerPerson: Double {
        return grandTotal / Double(store.numberOfPeople)
    }

    private var currencyIdentifier: String {
        locale.currency?.identifier ?? "USD"
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $store.checkAmount, format: .currency(code: currencyIdentifier)
                    )
                    .keyboardType((.decimalPad))
                    
                    PartySizePickerView(partySize: $store.numberOfPeople)
                }
                
                Section("How much do you want to tip?") {
                    TipPickerView(tip: $store.tipType)
                }
                
                Section("Total Amount") {
                    Text(grandTotal, format: .currency(code: currencyIdentifier)
                    )
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: currencyIdentifier)
                    )
                }
            }
            .navigationTitle("We Split")
        }
    }
}

#Preview {
    WeSplitView(
        store: Store( initialState: WeSplit.State()) {
            WeSplit()
        }
    )
}
