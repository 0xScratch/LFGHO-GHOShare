//
//  ProfileView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI
import Charts

struct ProfileView: View {
    
    let catData = [PetData(type: "cat", population: 30)]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ZStack(alignment: .bottomLeading) {
                        Image("bg_aave_2")
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 180)
                            .clipped()
                            .brightness(-0.5)
                    
                        
                        VStack {
                            ThinDonutChartView(data: catData)
                                .overlay(
                                    VStack {
                                        Text("Borrow APY")
                                            .font(.caption)
                                        
                                        Text("3.49%")
                                            .font(.system(size: 22, weight: .bold))
                                    }
                                )
                                .padding(20)
                            Spacer()
                            VStack {
                                HStack {
                                    NavigationLink  {
                                        AaveDashboard()
                                    } label: {
                                        Text("Aave Dashboard")
                                            .font(.system(size: 18))
                                            .foregroundColor(.primary)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.thinMaterial)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
                
                Section {
                    HStack(spacing: 16) {
                        Image("metamask")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .cornerRadius(6)
                        
                        Text("MetaMask")
                        
                        Spacer()
                        
                        Text("Connected")
                            .foregroundStyle(.gray)
                    }
                    HStack(spacing: 16) {
                        Image("nkoorty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .cornerRadius(6)
                        
                        Text("AA Wallet")
                        
                        Spacer()
                        
                        Text("Connected")
                            .foregroundStyle(.gray)
                    }
                } header: {
                    Text("Connections")
                }
                
                Section {
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Wallet", systemImage: "wallet.pass")
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Settings", systemImage: "gearshape")
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Add Friends", systemImage: "person.badge.plus")
                        }
                    }
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Label("Details", systemImage: "info.circle")
                        }
                    }
                } header: {
                    Text("Settings")
                }
                
                Section {
                    Button {
                        UserDefaults.standard.set(false, forKey: "signin")
                    } label: {
                        Text("Log out")
                            .foregroundStyle(.red)
                    }
                } header: {
                    Text("Disconnect")
                }
            }
            .navigationTitle("Home")
            .overlay(
                ProfileImageView()
                    .padding(.trailing, 20)
                    .offset(x: 0, y: -50)
            , alignment: .topTrailing)
        }
    }
}

#Preview {
    ProfileView()
        .preferredColorScheme(.dark)
}

struct PetData {
    let type: String
    let population: Double
}

struct ThinDonutChartView: View {
    var data: [PetData]
    
    var body: some View {
        Chart {
            ForEach(data, id: \.type) { dataItem in
                SectorMark(
                    angle: .value("Population", dataItem.population),
                    innerRadius: .ratio(0.78), // Adjust this to change the thickness of the donut
                    outerRadius: .ratio(1)
                )
                .foregroundStyle(.accent)
            }
        }
        .frame(height: 140)
        .chartLegend(.hidden)
    }
}

struct ProfileImageView: View {
    var body: some View {
        Image("nkoorty")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

