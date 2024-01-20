//
//  GroupOverview.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct GroupOverview: View {
    var group: Group
    var body: some View {
        VStack {
            List {
                Section {
                    ZStack(alignment: .bottomLeading) {
                        Image("bg_aave")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .clipped()
                        VStack {
                            Text("You owe")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.top, 20)
                                .padding(.bottom, 4)
                            Text("254.31")
                                .font(.system(size: 46, weight: .bold))
                            Spacer()
                            Text("GHO ($US)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .background(.thinMaterial)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                .cornerRadius(20)
                
                Section {
                    ForEach(members, id: \.id) { member in
                        MemberView(member: member)
                    }
                    HStack {
                        Image(systemName: "plus")
                        
                        Text("Add members")
                    }
                } header: {
                    Text("Members")
                }
                .headerProminence(.increased)
                
                Section {
                    Text("Hello")
                } header: {
                    Text("Expenses")
                }
                .headerProminence(.increased)
                
                Section {
                    Text("Hello")
                } header: {
                    Text("Transactions")
                }
                .headerProminence(.increased)
            }
            .navigationTitle(group.name)
        }
    }
}

#Preview {
    GroupOverview(group: groups[0])
        .preferredColorScheme(.dark)
}

