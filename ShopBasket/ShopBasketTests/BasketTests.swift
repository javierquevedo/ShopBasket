//
//  BasketTests.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 02.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import XCTest

class BasketTests: XCTestCase {
    var currency:Currency?
    override func setUp() {
        super.setUp()
        do {
            if let file = Bundle.main.url(forResource: "currenciesMock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                self.currency = try Currency(jsonObject:jsonObject)
            } else {
                XCTFail("Unable to find currencies mock")
            }
        } catch {
            XCTFail("Unable to parse currencies mock")
            print(error.localizedDescription)
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddAndRemoteItems() {
        var basket:Basket = Basket(currency: self.currency!)
        
        XCTAssertEqual(0, basket.numberOf(.peas), "Should be 0 item")

        basket.addItem(.beans)
        basket.addItem(.eggs)
        basket.addItem(.milk)
        basket.addItem(.peas)
        
        XCTAssertEqual(1, basket.numberOf(.beans), "Should be 1 item")
        XCTAssertEqual(1, basket.numberOf(.eggs), "Should be 1 item")
        XCTAssertEqual(1, basket.numberOf(.milk), "Should be 1 item")
        XCTAssertEqual(1, basket.numberOf(.peas), "Should be 1 item")
        
        basket.addItem(.beans, 5)
        basket.addItem(.beans)
        XCTAssertEqual(7, basket.numberOf(.beans), "Should be 7 items")
        
        basket.removeItem(.beans)
        XCTAssertEqual(6, basket.numberOf(.beans), "Should be 6 items")
        XCTAssertEqual(1, basket.numberOf(.peas), "Should be 1 item")
        

        basket.removeItem(.beans,100)
        XCTAssertEqual(0, basket.numberOf(.beans), "Should be 0 items")
    }
    
    func testCalculatePrice() {
        var basket:Basket = Basket(currency: self.currency!)
        basket.addItem(.beans)
        basket.addItem(.eggs)
        basket.addItem(.milk)
        basket.addItem(.peas)
        XCTAssertEqualWithAccuracy(basket.totalPrice(), 5.08, accuracy: 0.000000001, "Total price should be correct")
        basket.addItem(.peas)
        basket.removeItem(.milk)
        XCTAssertEqualWithAccuracy(basket.totalPrice(), 4.73, accuracy: 0.000000001, "Total price should be correct")
    }
    
    func testCalculatePriceWithExchange() {
        var basket:Basket = Basket(currency: self.currency!)
        basket.addItem(.beans)
        XCTAssertEqualWithAccuracy(basket.totalPrice("EUR"), 0.638460919, accuracy: 0.000000001, "Total price in a difference currency should be correct")
        basket.addItem(.eggs)
        basket.addItem(.milk)
        basket.addItem(.peas)
        XCTAssertEqualWithAccuracy(basket.totalPrice("EUR"), 4.44298832, accuracy: 0.000000001, "Total price in a difference currency should be correct")
    }
}
