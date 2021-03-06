//
//  Currency.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

struct Currency: Exchangeable {
    
    // MARK: - Errors
    enum CurrencyError: String, Error {
        case InvalidJson = "Invalid Json."
    }

    // MARK: - Public Properties
    public let rates:[String: Double]
    public let code:String
    public let exchanges:[String]

    // MARK: - Lifecycle
    init(code:String, rates:[String:Double]) {
        self.rates = rates;
        self.code = code
        self.exchanges = Array(self.rates.keys).sorted{ $0.compare($1, options: .caseInsensitive) == .orderedAscending }
    }
    
    init(jsonObject:Any) throws {
        guard let data:[String:Any] = jsonObject as? [String:Any],
            var  rates = data["quotes"] as? [String: Double],
            let code = data["source"] as? String
            else {
            throw (CurrencyError.InvalidJson)
        }
        
        let keys = Array(rates.keys)
        for exchangeCode:String in keys {
            if let entry = rates.removeValue(forKey: exchangeCode) {
                let index = exchangeCode.index(exchangeCode.startIndex, offsetBy: code.characters.count)
                rates[exchangeCode.substring(from: index)] = entry
            }
        }
        self.init(code:code, rates:rates)
    }

    // MARK: - Public Methods
    
    /**
     Returns the exchange rate for a given currency code
     
     @param code Currency code to retrieve the rate for
     
     @return The rate, nil if not available
     */
    public func rate(code:String)->Double? {
        return self.rates[code]
    }
    
    /**
     Exchanges an amount from USD to a given Currency Code
     
     @param amount The amount to exchange
     @param code   The target currency code
     
     @return The total amount in the target currency
     */
    public func exchange(_ amount:Double, code:String) -> Double? {
        var rate = 1.0
        if let c = rates[code] {
           rate = c
        }
        return rate * amount;
    }
}
