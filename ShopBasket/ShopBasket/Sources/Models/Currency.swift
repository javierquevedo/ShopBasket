//
//  Currency.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

struct Currency: Exchangeable {
    
    enum CurrencyError: String, Error {
        case InvalidJson = "Invalid Json."
    }
    
    public let rates:[String: Double]
    public let code:String
    
    public let exchanges:[String]
    
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
        rates.removeValue(forKey: code) // Remove self conversion
        self.init(code:code, rates:rates)
    }

    func rate(code:String)->Double? {
        return self.rates[code]
    }
    
    func exchange(_ amount:Double, code:String) -> Double? {
        var val:Double? = nil
        if let c = rates[code] {
            val = c * amount
        }
        return val;
    }
}
