//
//  Settings.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import Foundation
import SwiftUI

public class Settings: ObservableObject {
    @AppStorage("createdWallet", store: UserDefaults.standard) public var createdWallet: Bool = false
    @AppStorage("metamaskConnected", store: UserDefaults.standard) public var connectedMetaMask: Bool = false
}
