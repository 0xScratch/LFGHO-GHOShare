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

var groups: [Group] = [
    Group(name: "SwiftUI", imageUrl: "nkoorty", memberCount: 120.0, owedAmount: 250.50, open: true),
    Group(name: "Developers", imageUrl: "nkoorty", memberCount: 200.0, owedAmount: 150.0, open: false),
    Group(name: "Tech Innovators", imageUrl: "nkoorty", memberCount: 50.0, owedAmount: 300.0, open: true),
    Group(name: "Designers", imageUrl: "nkoorty", memberCount: 75.0, owedAmount: 220.75, open: false),
    Group(name: "Entrepreneurs", imageUrl: "nkoorty", memberCount: 90.0, owedAmount: 180.0, open: true)
]
