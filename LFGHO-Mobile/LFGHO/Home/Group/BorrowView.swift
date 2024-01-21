//
//  BorrowView.swift
//  GhoShare
//
//  Created by Artemiy Malyshau on 21/01/2024.
//

import SwiftUI

struct BorrowView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let catData = [PetData(type: "cat", population: 30)]
    
    @State private var borrowAmount: Double = 4500
    @State private var stakedAmount: Double = 35
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ZStack(alignment: .bottomLeading) {

                        VStack {
                            ThinDonutChartView(data: catData)
                                .overlay(
                                    VStack {
                                        Text("Borrow APY")
                                            .font(.caption)
                                        
                                        Text("\(String(format: "%.2f", borrowAmount/1000 * 0.8))%")
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
                            .cornerRadius(12)
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
                
                Section(header: Text("Staked ETH amount")) {
                    HStack {
                        Slider(
                            value: $stakedAmount,
                            in: 0...1000,
                            step: 1
                        )
                        .accentColor(.blue)
                        Text("\(Int(stakedAmount)) ETH")
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
                        
                        Text("2475 GHO = 1 ETH")
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
                        Text("Minimum ETH stake")
                        
                        Spacer()
                        
                        Text("0.00001 ETH")
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
            .navigationTitle("Borrow")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

#Preview {
    BorrowView()
        .preferredColorScheme(.dark)
}
