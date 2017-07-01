//
//  JSONSerializable.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import Foundation

protocol JSONSerializable {
    mutating func fromJson(jsonObject:Any)
    func toJson()->Any?
}
