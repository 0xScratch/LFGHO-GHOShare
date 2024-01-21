//
//  AaveDashboard.swift
//  LFGHO
//
//  Created by Artemiy Malyshau on 20/01/2024.
//

import SwiftUI

struct AaveDashboard: View {
    
    let catData = [PetData(type: "cat", population: 30)]
    
    @State private var borrowAmount: Double = 10000
    @State private var stakedAmount: Double = 35
    
    var body: some View {
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
                                Text("Borrow balance")
                                    .font(.system(size: 18))
                                    .foregroundColor(.primary)
                                    .bold()
                                
                                Spacer()
                                
                                Text("Amount")
                                    .padding(.trailing, 18)
                                    .bold()
                                
                                Text("APY")
                                    .bold()
                            }
                            .padding(.horizontal)
                            .padding(.top, 12)
                            .padding(.bottom, 6)
                            
                            Divider()
                            
                            HStack {
                                Rectangle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(.accent)
                                    .cornerRadius(50)
                                
                                Text("At a discount")
                                    .font(.system(size: 18))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text("\(String(format: "%.2f", borrowAmount))")
                                Text("3.49%")
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            
                            HStack {
                                Rectangle()
                                    .frame(width: 6, height: 6)
                                    .foregroundColor(.accent)
                                    .brightness(0.5)
                                    .cornerRadius(50)
                                
                                Text("Exceeds discount")
                                    .font(.system(size: 18))
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text("0.00")
                                Text("6.32%")
                            }
                            .padding(.horizontal)
                            .padding(.top, 4)
                            .padding(.bottom, 12)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.thinMaterial)
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            Section(header: Text("Borrow amount")) {
                HStack {
                    Slider(
                        value: $borrowAmount,
                        in: 1...10000,
                        step: 1
                    )
                    .accentColor(.purple)
                    Text("\(Int(borrowAmount)) GHO")
                        .foregroundColor(.gray)
                }
            }

            Section(header: Text("Staked AAVE amount")) {
                HStack {
                    Slider(
                        value: $stakedAmount,
                        in: 0...1000,
                        step: 1
                    )
                    .accentColor(.blue)
                    Text("\(Int(stakedAmount)) AAVE")
                        .foregroundColor(.gray)
                }
            }
            
            Button {
                
            } label: {
                Label("Borrow Specified Amount", systemImage: "dollarsign.arrow.circlepath")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue)
                    )
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            Section {
                HStack {
                    Text("Discountable amount")
                    
                    Spacer()
                    
                    Text("100 GHO = 1 AAVE")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Text("Discount")
                    
                    Spacer()
                    
                    Text("30%")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Text("APY with Discount")
                    
                    Spacer()
                    
                    Text("3.49%")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Text("Minimum AAVE stake")
                    
                    Spacer()
                    
                    Text("0.001 AAVE")
                        .foregroundStyle(.gray)
                }
                HStack {
                    Text("Minimum GHO borrow")
                    
                    Spacer()
                    
                    Text("1.00 GHO")
                        .foregroundStyle(.gray)
                }
            } header: {
                Text("Discount model parameters")
            } footer: {
                Text("Discount parameters are decided by the Aave community and may be changed over time.")
            }
        }
        .navigationTitle("Aave Dashboard")
    }
}

#Preview {
    AaveDashboard()
        .preferredColorScheme(.dark)
}
