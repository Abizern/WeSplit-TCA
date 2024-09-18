//
//  Public Domain --- See License file for details
//

import SwiftUI
import Testing
@_spi(Experimental) import SnapshotTesting
@testable import WeSplit_TCA


private let tipDescriptions: [(TipType, String)] = [
    (.none, "0%"),
    (.low, "10%"),
    (.medium, "20%"),
    (.good, "25%"),
    (.great, "30%")
]

private let scaleFactors: [(TipType, Double)] = [
    (.none, 1.0),
    (.low, 1.1),
    (.medium, 1.2),
    (.good, 1.25),
    (.great, 1.3)
]


@Suite("Tests for the TipPicker component", .tags(.tips))
struct TipPickerTests {
    @Test("Displayed tip percentages are correct", arguments: tipDescriptions)
    func percentage(from input: (TipType, String)) {
        #expect(String(describing: input.0) == input.1)
    }

    @Test("Tip scale factors are correct", arguments: scaleFactors)
    func scaleFactor(from input: (TipType, Double)) {
        #expect(input.0.scaleFactor == input.1)
    }
}

@Suite("TipPicker snapshot tests", .tags(.snapshots), .snapshots(record: .missing))
struct TipPickerSnapshotTests {
    @MainActor
    @Test func mediumTipView() {
        let view = Form {
            TipPickerView(tip: .constant(.medium))
        }
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))
    }
}

