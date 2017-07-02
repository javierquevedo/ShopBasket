//
//  CurrencyTests.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import XCTest

class CurrencyTests: XCTestCase {
    
    var jsonObject:Any? = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        do {
            if let file = Bundle.main.url(forResource: "currenciesMock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                self.jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            } else {
                XCTFail("Unable to find currencies mock")
            }
        } catch {
            XCTFail("Unable to parse currencies mock")
            print(error.localizedDescription)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialisationWithJson() {
        XCTAssertNoThrow(try Currency(jsonObject:self.jsonObject!))
        XCTAssertThrowsError(try Currency(jsonObject:[]))
        
        do {
            let currency = try Currency(jsonObject:self.jsonObject!)
            XCTAssertEqual(currency.code, "USD")
            print(currency.exchanges.count);
            XCTAssertEqual(currency.exchanges.count, 169)
        }
        catch {
            XCTFail("Error creating currency")
        }
    }
    
    func testRates() {
        do {
            let currency = try Currency(jsonObject:self.jsonObject!)
            XCTAssertEqual(currency.rate(code: "AED"), 3.672504)
            XCTAssertEqual(currency.rate(code: "BTN"), 64.550003)
            XCTAssertEqual(currency.rate(code: "CRC"), 564.77002)
            XCTAssertEqual(currency.rate(code: "ZWL"), 322.355011)
            XCTAssertNil(currency.rate(code: "NOT A CURRENCY"))
        }
        catch {
           XCTFail("Error creating currency")
        }
    }
    
    func testExchange() {
        do {
            let currency = try Currency(jsonObject:self.jsonObject!)
            XCTAssertEqual(currency.exchanges.count, 169)
            XCTAssertEqual(currency.exchanges.first, "AED")
            XCTAssertEqual(currency.exchanges.last, "ZWL")
            XCTAssertEqual(currency.exchange(12.0, code: "AED"), 44.070048)
            XCTAssertEqual(currency.exchange(50.0, code: "EUR"), 43.7302)
            XCTAssertEqual(currency.exchange(0.0, code: "GBP"), 0.0)
            XCTAssertEqual(currency.exchange(12.56859847, code: "FJD"), 25.77196143712888)
        }
        catch {
            XCTFail("Error creating currency")
        }
    }
}
