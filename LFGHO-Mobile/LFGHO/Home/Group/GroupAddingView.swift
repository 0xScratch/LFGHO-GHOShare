//
//  GroupAddingView.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import SwiftUI
import LocalAuthentication

struct GroupAddingView: View {
    @ObservedObject var viewModel: GroupViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var newGroupName: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Group Info")) {
                    TextField("Group Name", text: $newGroupName)
                }
                
                Button("Create Group") {
                    authenticate()
                }
                
                Section {
                    Text("By creating a group, you agree to creating a Vault for the allocation of GHO tokens amongst all future users within the group.")
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Add Group")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        viewModel.addGroup(
                            name: newGroupName,
                            imageUrl: "group_img2",
                            memberCount: 1,
                            owedAmount: 0,
                            open: false
                        )
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

//#Preview {
//    GroupAddingView()
//        .preferredColorScheme(.dark)
//}


extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
