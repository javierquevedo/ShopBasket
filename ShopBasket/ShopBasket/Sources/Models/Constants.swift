//
//  Constants.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 04.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

struct C {
    
    // Physics Constants
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
    
    // Storyboard
    static let CurrencySelectorModalSegueId = "CurrencySelectorModal"
    static let ShopSpriteKidEmbeddedSegueId = "ShopSpriteKitSegue"
    static let CurrencyCellId = "CurrencyCell"
    
    static let ShopSpawnXMax = 100.0
    static let ShopSpawnXMin = -100.0
    static let ShopSpawnY = -315.0
    
    
}
