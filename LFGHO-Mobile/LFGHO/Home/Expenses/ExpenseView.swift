//
//  ExpenseView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct ExpenseView: View {
    var expense: Expense
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "dollarsign")
                
            
            VStack(alignment: .leading) {
                Text(expense.title)
                
                Text(expense.name)
                    .font(.caption)
                    .bold()
            }
            
            Spacer()
            
            Text("$\(String(format: "%.2f", expense.amount))")
                .bold()
        }
    }
}

#Preview {
    ExpenseView(expense: expenses[0])
        .preferredColorScheme(.dark)
}
