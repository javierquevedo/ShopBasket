//
//  Exchangeable.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

protocol Exchangeable {
    var exchanges:[String] {get}
    func rate(code:String)->Double?
    func exchange(_ amount:Double, code:String) -> Double?
}
