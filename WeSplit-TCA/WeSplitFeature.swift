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
        var focusedField: Field?
        var numberOfPeople: Int = 2
        var tipType: TipType = .medium

        enum Field: String, Hashable {
            case checkAmount
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case doneButtonTapped
    }

    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .doneButtonTapped:
                state.focusedField = nil
                return .none
            }


        }
    }
}


struct WeSplitView: View {
    @Bindable var store: StoreOf<WeSplit>
    @FocusState var focusedField: WeSplit.State.Field?
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
                    .focused($focusedField, equals: .checkAmount)

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
            .bind($store.focusedField, to:$focusedField)
            .navigationTitle("We Split")
            .toolbar {
                if focusedField == .checkAmount {
                    Button("Done") {
                        store.send(.doneButtonTapped)
                    }
                }
            }
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
