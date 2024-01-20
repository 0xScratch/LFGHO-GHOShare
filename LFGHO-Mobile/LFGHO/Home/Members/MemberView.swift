//
//  MemberView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct MemberView: View {
    var member: Member
    var body: some View {
        HStack(spacing: 10) {
            Image(member.profileImage)
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .cornerRadius(50)
            
            Text(member.name)
                .bold()
        }
        .padding(.vertical, 2)
    }
}
