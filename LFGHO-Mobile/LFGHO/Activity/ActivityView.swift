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
                Section(header: Text("Recent Acitivity")) {
                    ForEach(activities, id: \.id) { activity in
                            ActivityPreview(activity: activity)
                    }
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
