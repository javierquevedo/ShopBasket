//
//  Constants.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 04.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

struct C {
    
    // MARK: - Prices in USD
    static let PeasPrice = 0.95
    static let EggsPrice = 2.1
    static let MilkPrice = 1.3
    static let BeansPrice = 0.73
    
    
    
    // MARK: - Physics
    static let Physics = [
        String(describing: Product.peas): [
            "restitution": 0.6,
            "mass": 0.10
        ],
        String(describing: Product.milk): [
            "restitution": 0.3,
            "mass": 0.20
        ],
        String(describing: Product.eggs): [
            "restitution": 0.2,
            "mass": 0.9
        ],
        String(describing: Product.beans): [
            "restitution": 0.6,
            "mass": 0.5
        ]
    ]
    
    // MARK: - Storyboard
    static let CurrencySelectorModalSegueId = "CurrencySelectorModal"
    static let ShopSpriteKidEmbeddedSegueId = "ShopSpriteKitSegue"
    static let CurrencyCellId = "CurrencyCell"
    
    // MARK: - Scene
    static let ShopSpawnXMax = 100.0
    static let ShopSpawnXMin = -100.0
    static let ShopSpawnY = 250
    
    // MARK: - Files
    static let ShopScene = "ShopScene"
    
    // MARK: - WebService
    static let RatesKey:String = "55566fb31213c62ab156c3e0301403ff"
    static let RatesUrl:String = "http://www.apilayer.net/api/live?access_key="
    
    // MARK: - Files
    static let CurrencyMockFile = "currenciesMock"
    static let CurrencyMockExtension = "json"
}
