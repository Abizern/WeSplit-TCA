//
//  Public Domain --- See License file for details
//

import SwiftUI

enum TipType: CustomStringConvertible, CaseIterable, Identifiable{
    case none
    case low
    case medium
    case good
    case great

    var id: Self { self }

    var description: String {
        switch self {
        case .none: return "0%"
        case .low: return "10%"
        case .medium: return "20%"
        case .good: return "25%"
        case .great: return "30%"
        }
    }

    var scaleFactor: Double {
        switch self {
        case .none: return 1
        case .low: return 1.1
        case .medium: return 1.2
        case .good: return 1.25
        case .great: return 1.3
        }
    }
}

struct TipPickerView: View {
    @Binding var tip: TipType

    var body: some View {
        Picker("Tip", selection: $tip) {
            ForEach(TipType.allCases) { tip in
                Text(String(describing: tip))
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    @Previewable @State var tip: TipType = .medium
    Form {
        TipPickerView(tip: $tip)
    }
}
