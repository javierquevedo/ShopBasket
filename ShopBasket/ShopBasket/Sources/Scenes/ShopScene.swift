//
//  ShopScene.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 03/07/2017.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import SpriteKit

class ShopScene: SKScene {
    
    override func didMove(to view: SKView) {
    }
    
    func addProduct(_ product:Product, touchHandler:@escaping ((Product)->Void)) {
        let node = ShopSKNodeFactory.productGravitySpriteNode(product)
        node.touched = touchHandler
        node.position.x = CGFloat(arc4random_uniform(UInt32(2.0 * C.ShopSpawnXMax))) + CGFloat(C.ShopSpawnXMin);
        node.position.y = CGFloat(C.ShopSpawnY)
        self.addChild(node)
    }
}
