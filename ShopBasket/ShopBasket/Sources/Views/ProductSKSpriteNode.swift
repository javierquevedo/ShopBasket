//
//  ProductSKSpriteNode.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 03.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import SpriteKit

class ProductSKSpriteNode: SKSpriteNode {

    init(product:Product) {
        let texture = SKTexture(imageNamed: "ball")
        super.init(texture:texture, color: UIColor.clear, size:texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
