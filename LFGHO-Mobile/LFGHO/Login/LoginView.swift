//
//  LoginView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI
import LocalAuthentication
import metamask_ios_sdk
import Combine

struct LoginView: View {
    
    @ObservedObject var settings = Settings()
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showWalletView: Bool = false
    
    @ObservedObject var metaMaskSDK = MetaMaskSDK.shared(appMetadata)
    private static let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")

    @State private var errorMessage = ""
    @State private var showError = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                    .frame(height: 80)
                
                VStack(alignment: .center) {
                    Image("ghoshare")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 140)
                        .cornerRadius(34)
                }
                
                Spacer()
                    .frame(height: 20)
                
                /// Title
                Text("GhoShare")
                    .font(.system(size: 22, weight: .bold))
                
                Spacer()
                    .frame(height: 70)
                
                Button {
                    Task {
                        await connectSDK()
                    }
                } label: {
                    HStack(spacing: 12) {
                        Text("Log in with MetaMask")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .overlay(
                        HStack {
                            Image("metamask")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 28, height: 28)
                            
                            Spacer()
                        }
                        .padding()
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.1))
                            .frame(height: 50)
                    )
                    .padding(.top, 20)
                }
                
                Spacer()
                    .frame(height: 36)
                
                HStack{
                    Rectangle()
                        .frame(width: 150, height: 2)
                        .cornerRadius(3)
                        .foregroundColor(.gray)
                    
                    Text("OR")
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .frame(width: 150, height: 2)
                        .cornerRadius(3)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                    .frame(height: 18)
                
                
                Button {
                    showWalletView.toggle()
                } label: {
                    HStack(spacing: 12) {
                        Text("Create GhoShare Wallet")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .hCenter()
                    .padding(.leading, 10)
                    .overlay(
                        HStack {
                            Image(systemName: "wallet.pass")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 16, height: 16)
                            
                            Spacer()
                        }
                        .padding()
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.1))
                            .frame(height: 50)
                    )
                    .padding(.top, 20)
                }
                
                Spacer()
                
                Text("By continuing, you agree to our User Agreement and Privacy Policy.")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.60))
                    .hCenter()
                    .padding(.top, 20)
                    .padding(.leading, 4)
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showWalletView) {
                AbstractionView {
                    self.showWalletView = false
                    authenticate()
                }
                .presentationDetents([.fraction(0.4)])
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
                    UserDefaults.standard.set(true, forKey: "signin")
                    settings.createdWallet = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
    func connectSDK() async {
        let result = await metaMaskSDK.connect()
        UserDefaults.standard.set(true, forKey: "signin")
        settings.connectedMetaMask = true
        
        switch result {
        case let .failure(error):
            errorMessage = error.localizedDescription
            showError = true
        default:
            break
        }
    }
}

#Preview {
    LoginView()
        .preferredColorScheme(.dark)
}
