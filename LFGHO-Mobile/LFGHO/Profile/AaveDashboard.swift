//
//  AaveDashboard.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct AaveDashboard: View {
    var body: some View {
        List {
            Section {
                Text("Hello")
            }
        }
        .navigationTitle("Aave Dashboard")
    }
}

#Preview {
    AaveDashboard()
        .preferredColorScheme(.dark)
}
