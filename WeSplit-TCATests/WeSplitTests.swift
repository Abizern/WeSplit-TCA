//
//  Public Domain --- See License file for details
//

import ComposableArchitecture
import SwiftUI
import Testing
@_spi(Experimental) import SnapshotTesting
@testable import WeSplit_TCA

@Suite("WeSplit Tests", .tags(.weSplit))
struct WeSplitTests {
    @Test("Initial state values are correct")
    func initialStateValuesAreCorrect() {
        let state = WeSplit.State()

        #expect(state.checkAmount == 0.0)
        #expect(state.numberOfPeople == 2)
        #expect(state.tipType == .medium)
    }

    @Test("Basic bindings")
    func basicBindings() async {
        let store = await TestStore(initialState: WeSplit.State()) {
            WeSplit()
        }
        await store.send(\.binding.checkAmount, 10.0) {
            $0.checkAmount = 10.0
        }

        await store.send(\.binding.numberOfPeople, 3) {
            $0.numberOfPeople = 3
        }

        await store.send(\.binding.tipType, TipType.great) {
            $0.tipType = .great
        }
    }

    @MainActor
    @Test("Snapshot of initial screen", .tags(.snapshots))
    func snapshotInitialScreen() {
        let store =  Store(initialState: WeSplit.State()) {
            WeSplit()
        }

        let view = withDependencies {
            $0.locale = Locale(identifier: "en_US")
        } operation: {
            WeSplitView(store: store)
        }
        let vc =  UIHostingController(rootView: view)

        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))

    }

    @MainActor
    @Test("Snapshot of screen with entered values", .tags(.snapshots))
    func snapshotWithEnteredValues() {
        let store =  Store(initialState: WeSplit.State(checkAmount: 200.0, numberOfPeople: 3, tipType: .good)) {
            WeSplit()
        }

        let view = withDependencies {
            $0.locale = Locale(identifier: "en_US")
        } operation: {
            WeSplitView(store: store)
        }
        let vc =  UIHostingController(rootView: view)

        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))

    }
}
