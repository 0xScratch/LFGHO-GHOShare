//
//  Group.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct Group: Identifiable, Hashable {
    var name: String
    var imageUrl: String
    var id = UUID()
    var memberCount: Double
    var owedAmount: Double
    var open: Bool
}

