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
        
        //addProduct(.eggs)

        
        //product.position.x = 100
        //product.position.y = 100
        //self.addProductNode(.peas)
    }
    
    func onTouched(_ productNode:ProductSKSpriteNode)->Void {
        
    }
    
    func addProduct(_ product:Product, touchHandler:@escaping ((Product)->Void)) {
        let node = ShopSKNodeFactory.productGravitySpriteNode(product)
        node.touched = touchHandler
        node.position.x = 50
        node.position.y = 100
        self.addChild(node)
    }
}
