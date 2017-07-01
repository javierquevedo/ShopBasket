//
//  ShopBasketTests.swift
//  ShopBasketTests
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import XCTest
@testable import ShopBasket

class ShopBasketTests: XCTestCase {
    
    var jsonMock:Any?
    
    override func setUp() {
        super.setUp()
        
        do {
            if let file = Bundle.main.url(forResource: "currenciesMock", withExtension: "json") {
                let data = try Data(contentsOf: file)
                self.jsonMock = try JSONSerialization.jsonObject(with: data, options: [])
                print("test")
                
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
