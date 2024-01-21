//
//  ActivityView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Meow")
                }
            }
            .navigationTitle("Activity")
        }
    }
}

#Preview {
    ActivityView()
        .preferredColorScheme(.dark)
}
