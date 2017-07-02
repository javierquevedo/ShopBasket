//
//  Basket.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

enum Product {
    case peas
    case eggs
    case milk
    case beans
}

struct Basket {
    // Default product prices in USD
    public let prices = [
        Product.peas: 0.95,
        Product.eggs: 2.1,
        Product.milk: 1.3,
        Product.beans: 0.73,
    ]
    
    public var currency:Currency
    
    init (currency:Currency) {
        self.currency = currency
    }

    public var items:[Product:UInt] = [:]
  
    public func totalPrice(_ currencyCode:String = "USD") -> Double {
        var totalPrice:Double = 0
        for (product, amount) in self.items {
            totalPrice += currency.exchange(prices[product]!, code: currencyCode)! * Double(amount)
        }
        return totalPrice
    }
    
    public mutating func addItem(_ product:Product, _ amount:UInt = 1) -> Void {
        if let entry = items[product] {
            items[product] = entry + amount
        } else {
            items[product] = amount
        }
    }
    
    public mutating func removeItem(_ product:Product, _ amount:UInt = 1) -> Void {
        if let entry = items[product] {
            if amount > entry {
                items[product] = 0
            } else {
                items[product] = entry - amount
            }
        }
    }
    
    public func numberOf(_ product:Product) -> UInt {
       if let entry = items[product] {
            return entry
        }
        return 0
    }
}
