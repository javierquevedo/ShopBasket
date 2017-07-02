//
//  CurrencyViewModel.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 02.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

class CurrencyViewModel {
    
    public var currency:Currency
    
    public var exchangesCount:Int {
        get {
            return self.currency.exchanges.count
        }
    }
    
    init(currency:Currency) {
            self.currency = currency
    }
    
    func currencyCode(index:Int) -> String {
            return self.currency.exchanges[index]
    }
    
    func currencyRate(index:Int) -> Double {
        return self.currency.rate(code:self.currency.exchanges[index])!
    }
    
}
