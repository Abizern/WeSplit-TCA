//
//  Public Domain --- See License file for details
//

import ComposableArchitecture
import SwiftUI
import Testing
//@_spi(Experimental) import SnapshotTesting
@testable import WeSplit_TCA

@Suite("WeSplitFeature Tests", .tags(.weSplitFeature))
struct WeSplitFeatureTests {
    @Test("Initial state values are correct")
    func initialStateValuesAreCorrect() {
        let state = WeSplitFeature.State()

        #expect(state.checkAmount == 0.0)
        #expect(state.numberOfPeople == 2)
        #expect(state.tipType == .medium)
        #expect(state.grandTotal == 0.0)
        #expect(state.totalPerPerson == 0.0)
    }

    @Test("Synthesized values are correctly calculated")
    func synthesizedValuesAreCorrectlyCalculated() {
        let state = WeSplitFeature.State(
            checkAmount: 10.0,
            numberOfPeople: 3,
            tipType: .medium
        )

        #expect(state.grandTotal == 12.0)
        #expect(state.totalPerPerson == 4.0)
    }

    @MainActor
    @Test("Basic bindings")
    func basicBindings() async {
        let store = TestStore(initialState: WeSplitFeature.State()) {
            WeSplitFeature()
        }

        await store.send(\.binding.checkAmount, 10.0) {
            $0.checkAmount = 10.0
        }

        await store.send(\.binding.numberOfPeople, 3) {
            $0.numberOfPeople = 3
        }

        await store.send(\.binding.tipType, .great) {
            $0.tipType = .great
        }
    }
}
