//
//  LFGHOApp.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 19/01/2024.
//

import SwiftUI

@main
struct LFGHOApp: App {
    
    @AppStorage("signin") var isSignedIn = false
    
    var body: some Scene {
        WindowGroup {
            if !isSignedIn {
                LoginView()
                    .preferredColorScheme(.dark)
            } else {
                TabBarView()
                    .preferredColorScheme(.dark)
            }
        }
    }
}
