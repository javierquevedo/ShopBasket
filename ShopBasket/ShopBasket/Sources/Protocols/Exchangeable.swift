//
//  Exchangeable.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

protocol Exchangeable {
    /**
     Returns all available exchange codes
     
     @return All available exchange code
     */
    var exchanges:[String] {get}
    
    /**
     Returns the exchange rate for a given currency code
     
     @param code Currency code to retrieve the rate for
     
     @return The rate, nil if not available
     */
    func rate(code:String)->Double?
    
    /**
     Exchanges an amount from USD to a given Currency Code
     
     @param amount The amount to exchange
     @param code   The target currency code
     
     @return The total amount in the target currency
     */
    func exchange(_ amount:Double, code:String) -> Double?
}
