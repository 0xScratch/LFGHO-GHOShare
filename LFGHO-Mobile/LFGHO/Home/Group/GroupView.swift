//
//  GroupView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct GroupView: View {
    var group: Group
    var body: some View {
        HStack(spacing: 12) {
            Image(group.imageUrl)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .cornerRadius(50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(group.name)
                    .bold()
                
                Text("Members: \(String(format: "%.0f", group.memberCount))")
                    .font(.subheadline)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(group.open ? "Settled" : "Not Settled")
                    .foregroundColor(group.open ? .gray : .white)
                    .font(.system(size: 14))
                
                Text("\(String(format: "%.2f", group.owedAmount)) US$")
                    .bold()
            }
        }
    }
}

//#Preview {
//    GroupView(group: groups[1])
//        .preferredColorScheme(.dark)
//}
