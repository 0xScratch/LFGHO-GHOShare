//
//  HomeView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
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
                                .font(.system(size: 22, weight: .semibold))
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
                    Text("Moin")
                } header: {
                    Text("Groups")
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
