//
//  HomeView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var settings = Settings()
    @StateObject private var viewModel = GroupViewModel()
    @State private var addGroupView = false
    
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
                            Text("In total, you owe")
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.top, 20)
                                .padding(.bottom, 4)
                            Text(settings.connectedMetaMask ? "47.50" : "0.00")
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
                    if settings.connectedMetaMask {
                        ForEach(viewModel.groups1, id:\.id) { group in
                            NavigationLink(destination: GroupOverview(group: group)) {
                                GroupView(group: group)
                            }
                        }
                    } else {
                        ForEach(viewModel.groups, id:\.id) { group in
                            NavigationLink(destination: GroupOverview(group: group)) {
                                GroupView(group: group)
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Groups")
                        
                        Spacer()
                        
                        Text("See all")
                            .font(.system(size: 16))
                            .foregroundStyle(.blue)
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        addGroupView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $addGroupView) {
                GroupAddingView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
}
