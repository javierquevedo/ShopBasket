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
    // MARK: - Public Properties
    public let prices = [
        Product.peas: C.PeasPrice,
        Product.eggs: C.EggsPrice,
        Product.milk: C.MilkPrice,
        Product.beans: C.BeansPrice,
    ] // Default product prices in USD
    
    public var currency:Currency
    public var items:[Product:UInt] = [:]
    
    // MARK: - Lifecycle
    init (_ currency:Currency) {
        self.currency = currency
    }

    /**
     Returns the total price of the basket for a given currency code
     
     @param code Currency code to calculate the price for. USD by default
     
     @return The total amount
     */
    public func totalPrice(_ currencyCode:String = "USD") -> Double {
        var totalPrice:Double = 0
        for (product, amount) in self.items {
            totalPrice += currency.exchange(prices[product]!, code: currencyCode)! * Double(amount)
        }
        return totalPrice
    }
    
    // MARK: - Public Methods
    /**
     Adds an item to the basket
     
     @param product The product to add to the basket
     @param amount  The number of items to add of the product
     
     */
    public mutating func addItem(_ product:Product, _ amount:UInt = 1) -> Void {
        if let entry = items[product] {
            items[product] = entry + amount
        } else {
            items[product] = amount
        }
    }
    
    /**
     Removes an item from the basket. Overflows to 0 when trying to remove more than the existing
     
     @param code Currency code to calculate the price for. USD by default
     
     @param product The product to remove from the basket
     @param amount  The number of items to remove of the product
     
     */
    public mutating func removeItem(_ product:Product, _ amount:UInt = 1) -> Void {
        if let entry = items[product] {
            if amount > entry {
                items[product] = 0
            } else {
                items[product] = entry - amount
            }
        }
    }
    
    /**
     Returns the number of items of a product
     
     @param code Currency code to calculate the price for. USD by default
     
     @param product The product to retrieve the number of items
     
     @return The total amount of items of this product in the basket
     */
    public func numberOf(_ product:Product) -> UInt {
       if let entry = items[product] {
            return entry
        }
        return 0
    }
}
