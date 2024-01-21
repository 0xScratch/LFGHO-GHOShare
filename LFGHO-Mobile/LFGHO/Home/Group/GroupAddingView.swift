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
    @State private var owedAmount: String = ""
    @State private var deadlineDate = Date.now
    
    let owners = ["Pay in liquid", "Pay by borrowing"]
    
    @State private var selectedOwner: String = "Pay in liquid"
    
    let tokens = ["AAV", "USDC", "GHO"]
    
    @State private var selectedToken: String = "GHO"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Group Info")) {
                    TextField("Group Name", text: $newGroupName)
                    TextField("Owed Amount ($US)", text: $owedAmount)
                    Picker("Select token", selection: $selectedToken) {
                        ForEach(tokens, id: \.self) { token in
                            Text(token).tag(token)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    DatePicker(selection: $deadlineDate, in: Date.now..., displayedComponents: .date) {
                        Text("Select a deadline for the payment")
                    
                    }
                    Picker("Select payment type", selection: $selectedOwner) {
                        ForEach(owners, id: \.self) { owner in
                            Text(owner).tag(owner)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                }
                
                Section(header: Text("Add Members")) {
                    HStack {
                        Image(systemName: "plus")
                        
                        Text("Add members")
                    }
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
                    if let owedAmountValue = Double(self.owedAmount ?? "") {
                        // Proceed only if the conversion is successful
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            self.viewModel.addGroup(
                                name: self.newGroupName ?? "",
                                imageUrl: "group_img2",
                                memberCount: 1,
                                owedAmount: owedAmountValue,
                                open: false
                            )
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        // Handle the error scenario, perhaps show an alert to the user
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
