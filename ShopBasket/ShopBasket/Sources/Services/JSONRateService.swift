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
    
    public static let DefaultRatesPollInterval:TimeInterval = 60
    
    private let API_KEY:String = C.RatesKey
    private let API_URL:String = C.RatesUrl
    private var updatedHandler:((Currency, JSONRateServiceStatus, Error?)->Void)?
    private var shouldStop:Bool = false
    private var pollInterval:TimeInterval = DefaultRatesPollInterval
    
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
    
    
    func start(_ time:TimeInterval = DefaultRatesPollInterval,  updated:(@escaping (Currency, JSONRateServiceStatus, Error?)->Void)) {
        shouldStop = false
        pollInterval = time
        self.updatedHandler = updated
        self.poll()
    }
    
    private func poll() {
        getCurrency { (currency, status, error) in
            if let handler = self.updatedHandler {
                DispatchQueue.main.async {
                    handler(currency, status, error)
                }
            }
            if (!self.shouldStop) {
                DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + self.pollInterval, execute: {
                    self.poll()
                })
            }
        }
    }
    
    func stop() {
        shouldStop = true
    }
    
    private func getMockCurrency() -> Currency {
        let file = Bundle.main.url(forResource: C.CurrencyMockFile, withExtension: C.CurrencyMockExtension)
        let data = try! Data(contentsOf: file!)
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
        return try! Currency(jsonObject:jsonObject)
    }
}

