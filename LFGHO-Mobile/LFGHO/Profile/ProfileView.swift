//
//  ProfileView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Hello")
                }
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ProfileView()
}
