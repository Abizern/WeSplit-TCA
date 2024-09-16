//
//  Public Domain --- See License file for details
//

import ComposableArchitecture
import SwiftUI

@main
struct WeSplitApp: App {
    var body: some Scene {
        WindowGroup {
            WeSplitView(
                store: Store(initialState: WeSplitFeature.State()) {
                    WeSplitFeature()
                }
            )
        }
    }
}
