//
//  JQCurrencyService.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

class JQCurrencyService {
    init() {
        
    }
    
    func getAvailableCurrencies() {
        do {
            if let file = Bundle.main.url(forResource: "currenciesMock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
       
    }
}

