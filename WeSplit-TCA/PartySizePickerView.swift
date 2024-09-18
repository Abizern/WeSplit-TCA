//
//  Public Domain --- See License file for details
//

import SwiftUI

struct PartySizePickerView: View {
    @Binding var partySize: Int

    var body: some View {
        Picker("Number of People", selection: $partySize) {
            ForEach(2..<10, id: \.self) {
                Text("\($0) people")
            }
        }
    }
}

#Preview {
    @Previewable @State var partySize: Int = 2
    Form {
        PartySizePickerView(partySize: $partySize)
    }
}
