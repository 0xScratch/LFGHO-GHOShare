//
//  PayView.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import SwiftUI

struct PayView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 20)
                
                Text("You are sending funds in the specified currency towards the created vault. You are agreeing to our Terms of Service and Privacy Policy. Ensure you have understood these documents before proceeding.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                    .frame(height: 20)
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Label("Pay Jeevan 47.50 GHO", systemImage: "dollarsign")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue)
                        )
                }
                .padding(.top, 20)
                
                Spacer()

                .navigationTitle("Pay")
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
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    PayView()
        .preferredColorScheme(.dark)
}
