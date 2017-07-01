//
//  JQCurrencyService.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

class JSONRateService {
    
    private let API_KEY:String = INSERT YOUR KEY HERE
    private let API_URL:String = "http://www.apilayer.net/api/live?access_key="
    init() {
        
    }
    
    func getCurrency() {
        let url = URL(string:"\(API_URL)\(API_KEY)")
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            var currency:Currency? = nil
            print(json)
            do {
                    currency = try Currency(jsonObject: json)
                
            }
            catch {
                currency = nil
            }
            
        }
        task.resume()
        
       /* do {
            if let file = Bundle.main.url(forResource: "currenciesMock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }*/
    }
}

