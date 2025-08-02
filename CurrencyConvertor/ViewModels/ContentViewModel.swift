//
//  ContentViewModel.swift
//  CurrencyConvertor
//
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject{
    
    @Published var convertedAmount = 1.0
    @Published var baseAmount = 1.0
    @Published var baseCurrency:CurrencyChoice = .Usa
    @Published var convertedCurrency:CurrencyChoice = .Usa
    @Published var rates:Rates?
    @Published var isloading = false
    @Published var errorMessage = ""
    
    var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = ""
        return numberFormatter
    }
    
    var conversionRate : Double{
        if let rates = rates,let baseExchangeRate = rates.rates[baseCurrency.rawValue],let convertedExchangeRate = rates.rates[convertedCurrency.rawValue]{
           return convertedExchangeRate/baseExchangeRate
            
        }
        return 1
    }

    func fetchRates()async{
        
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=c6b8319649264eb18ba0057bc167bcbd") else {
            errorMessage = "Could not Fetch rates."
            print("API URL is not valid")
            return
        }

        let urlRequest = URLRequest(url: url)
        isloading = true
        
        do{
           let (data,_) = try await URLSession.shared.data(for: urlRequest)
            rates = try JSONDecoder().decode(Rates.self, from: data)
        } catch {
            errorMessage = "Could not Fetch rates."
            print(error.localizedDescription)
        }
        isloading = false
       
    }
    
    func convert(){
        if let rates = rates,let baseExchangeRate = rates.rates[baseCurrency.rawValue],let convertedExchangeRate = rates.rates[convertedCurrency.rawValue]{
            convertedAmount = (convertedExchangeRate/baseExchangeRate) * baseAmount
            
        }
        
    }
    
}


