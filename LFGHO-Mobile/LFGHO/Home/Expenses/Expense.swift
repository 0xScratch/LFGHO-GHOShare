//
//  Expense.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct Expense: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var title: String
    var amount: Double
}

var expenses: [Expense] = [
    Expense(name: "Artemiy", title: "Uber ride to hotel", amount: 24),
    Expense(name: "Jeevan", title: "Dinner at the Mandarin", amount: 153),
    Expense(name: "Artemiy", title: "Lunch in Boston", amount: 34)
]
