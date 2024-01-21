//
//  Member.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct Member: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var profileImage: String
}

var members: [Member] = [
    Member(name: "Artemiy", profileImage: "icon"),
    Member(name: "Jeevan", profileImage: "icon2")
]
