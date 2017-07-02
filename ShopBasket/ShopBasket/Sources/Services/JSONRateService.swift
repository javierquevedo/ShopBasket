//
//  JQCurrencyService.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

class JSONRateService {
    
    enum JSONRateServiceStatus: Int {
        case success = 0
        case connectivityIssue = 1
        case invalidData = 2
        case failed = 3
    }
    
    
    
    private let API_KEY:String = INSERT YOUR KEY HERE
    private let API_URL:String = "http://www.apilayer.net/api/live?access_key="
    
    init() {
        
    }
    
    func getCurrency(completed:@escaping (Currency, JSONRateServiceStatus, Error?)->Void) {
        let url = URL(string:"\(API_URL)\(API_KEY)")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            // Error in the connection
            guard error == nil else {
                completed(self.getMockCurrency(), .connectivityIssue, error)
                return
            }
            guard let data = data else {
                completed(self.getMockCurrency(), .invalidData, error)
                return
            }
            
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            
            do {
                    let currency = try Currency(jsonObject: json)
                    completed(currency, .success, error)
            }
            catch {
                completed(self.getMockCurrency(), .invalidData, error)            }
        }
        task.resume()
    }
    
    private func getMockCurrency() -> Currency {
        let file = Bundle.main.url(forResource: "currenciesMock", withExtension: "json")
        let data = try! Data(contentsOf: file!)
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
        return try! Currency(jsonObject:jsonObject)
    }
}

