//
//  AbstractionView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct AbstractionView: View {
    var onWalletCreation: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                
                Rectangle()
                    .frame(width: 50, height: 4)
                    .cornerRadius(50)
                    .foregroundColor(.gray)
                    .padding(.vertical, 8)
                
                Spacer()
            }
            
            Spacer().frame(height: 20)
            
            Text("Create a Wallet")
                .font(.system(size: 24, weight: .bold))
            
            Spacer().frame(height: 10)
            
            Text("You are creating an EIP-4337 wallet without a seed phrase. You are agreeing to our Terms of Service and Privacy Policy. Ensure you have understood these documents before proceeding.")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button(action: onWalletCreation) {
                Label("Create GhoShare Wallet", systemImage: "wallet.pass")
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
        }
        .padding(.horizontal, 16)
    }
}



//#Preview {
//    AbstractionView($showWalletView)
//        .preferredColorScheme(.dark)
//}
