//
//  ProfileView.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI
import Charts
import metamask_ios_sdk
import Combine

struct ProfileView: View {
    
    @ObservedObject var settings = Settings()
    
    let catData = [PetData(type: "cat", population: 30)]
    
    @ObservedObject var metaMaskSDK = MetaMaskSDK.shared(appMetadata)
    private static let appMetadata = AppMetadata(name: "Dub Dapp", url: "https://dubdapp.com")

    @State private var errorMessage = ""
    @State private var showError = false
    
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
                    NavigationLink {
                    } label: {
                        HStack {
                            Image("onramper")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .cornerRadius(6)
                            
                            Text("Onramper")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text("Add funds")
                                .foregroundStyle(.gray)
                        }
                    }
                    Button {
                        Task {
                            await connectSDK()
                        }
                    } label: {
                        HStack(spacing: 16) {
                            Image("metamask")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 26, height: 26)
                                .cornerRadius(6)
                            
                            Text("MetaMask")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Text(settings.connectedMetaMask ? "Connected" : "Not Connected")
                                .foregroundStyle(.gray)
                        }
                    }
                    HStack(spacing: 16) {
                        Image("nkoorty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 26, height: 26)
                            .cornerRadius(6)
                        
                        Text("AA Wallet")
                        
                        Spacer()
                        
                        Text(settings.createdWallet ? "Connected" : "Not Connected")
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
    
    func connectSDK() async {
        let result = await metaMaskSDK.connect()
        settings.connectedMetaMask = true
        
        switch result {
        case let .failure(error):
            errorMessage = error.localizedDescription
            showError = true
        default:
            break
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
        Image("icon")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

