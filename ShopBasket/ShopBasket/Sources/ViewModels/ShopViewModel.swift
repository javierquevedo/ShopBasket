//
//  ShopViewModel.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 04.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

struct ShopViewModel {
    public var currency:Currency
    public var basket:Basket
    public var currentCode:String
    
    public var exchangesCount:Int {
        get {
            return self.currency.exchanges.count
        }
    }
    
    init(_ currency:Currency, code:String = "USD") {
        self.currency = currency
        self.currentCode = code
        self.basket = Basket(self.currency)
    }
    
    func currencyCode(index:Int) -> String {
        return self.currency.exchanges[index]
    }
    
    func currencyDisplayRate(index:Int)-> String{
        return String(format:"%0.2f", self.currencyRate(index: index))
    }
    
    func currencyRate(index:Int) -> Double {
        return self.currency.rate(code:self.currency.exchanges[index])!
    }
    
    mutating func set(currency:Currency) {
        self.currency = currency
        self.basket.currency = currency
    }
    
    mutating func addItem(_ product:Product) {
        self.basket.addItem(product)
    }
    
    mutating func removeItem(_ product:Product) {
        self.basket.removeItem(product)
    }
    
    func totalPrice()->String {
        return  String(format:"%0.2f", self.basket.totalPrice(self.currentCode))
    }
    
    

}
