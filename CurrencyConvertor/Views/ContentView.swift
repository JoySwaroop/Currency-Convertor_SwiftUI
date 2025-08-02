//
//  ContentView.swift
//  CurrencyConvertor
//
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @FocusState private var baseAmountIsFocussed:Bool
    @FocusState private var convertedAmountIsFocussed:Bool
    @State private var amount = ""
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                    Text(viewModel.errorMessage)
                        .foregroundStyle(.red)
                        .font(.system(size: 18,weight: .semibold))
                    Spacer()
                }
                Text("Amount")
                    .font(.system(size: 15))
                TextField("", value: $viewModel.baseAmount, formatter: viewModel.numberFormatter)
                    .focused($baseAmountIsFocussed)
                    .onSubmit {
                        viewModel.convert()
                        baseAmountIsFocussed = false
                        convertedAmountIsFocussed = false
                    }
                    .font(.system(size: 18,weight: .semibold))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .overlay(alignment: .trailing) {
                        HStack{
                            viewModel.baseCurrency.image()
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30,height: 30)
                                .clipShape(Circle())
                            Menu {
                                ForEach(CurrencyChoice.allCases) {currencyChoice in
                                    Button {
                                        viewModel.baseCurrency = currencyChoice
                                        viewModel.convert()
                                    } label: {
                                        Text(currencyChoice.fetchMenuName())
                                    }
                                    
                                }
                            } label: {
                                Text(viewModel.baseCurrency.rawValue)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16,weight: .bold))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 16,weight: .bold))
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        .padding(.trailing)
                    }
                HStack{
                    Spacer()
                    Image(systemName: "arrow.up.arrow.down")
                        .font(.system(size: 20,weight: .bold))
                        .padding(.vertical)
                    Spacer()
                }
                Text("Converted To")
                    .font(.system(size: 15))
                TextField("", value: $viewModel.convertedAmount, formatter: viewModel.numberFormatter)
                    .focused($convertedAmountIsFocussed)
                    .font(.system(size: 18,weight: .semibold))
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .overlay(alignment: .trailing) {
                        HStack{
                            viewModel.convertedCurrency.image()
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30,height: 30)
                                .clipShape(Circle())
                            Menu {
                                ForEach(CurrencyChoice.allCases) {currencyChoice in
                                    Button {
                                        viewModel.convertedCurrency = currencyChoice
                                        viewModel.convert()
                                    } label: {
                                        Text(currencyChoice.fetchMenuName())
                                    }
                                    
                                }
                            } label: {
                                Text(viewModel.convertedCurrency.rawValue)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16,weight: .bold))
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 16,weight: .bold))
                                    .foregroundStyle(.black)
                            }
                            
                        }
                        .padding(.trailing)
                    }
                HStack {
                    Spacer()
                    Text("1.0000 \(viewModel.baseCurrency.rawValue) = \(viewModel.conversionRate) \(viewModel.convertedCurrency.rawValue)")
                        .font(.system(size: 18,weight: .semibold))
                        .padding(.top,25)
                    Spacer()
                }
                
                
                
                
                
            }
            .padding(.horizontal)
            .task {
                await viewModel.fetchRates()
            }
            if viewModel.isloading{
                ZStack{
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .tint(.white)
                }
                
            }
            
        }.onTapGesture {
            viewModel.convert()
            baseAmountIsFocussed = false
            convertedAmountIsFocussed = false
        
       
        }
        
    }
}

#Preview {
    ContentView()
}
