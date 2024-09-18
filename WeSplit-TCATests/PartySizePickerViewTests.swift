//
//  Public Domain --- See License file for details
//

import SwiftUI
import Testing
@_spi(Experimental) import SnapshotTesting
@testable import WeSplit_TCA

@Suite("PartySizePickerView snapshot tests", .tags(.partySizePicker, .snapshots), .snapshots(record: .missing))
struct PartySizePickerViewTests {
    @Test("PartySizePickerView with 2 people")
    @MainActor
    func snapshotTest() throws {
        let view = Form {
            PartySizePickerView(partySize: .constant(2))
        }
        let vc = UIHostingController(rootView: view)
        assertSnapshot(of: vc, as: .image(on: .iPhone13Pro))
    }
}
