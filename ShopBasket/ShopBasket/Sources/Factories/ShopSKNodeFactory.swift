//
//  ShopSKNodeFactory.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 04.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import SpriteKit

struct ShopSKNodeFactory {
    
    /**
     Creates a gravity sprite node for a given product
     
     @param product The product to create the node of
     
     @return The product Sprite node with the corresponding physics characteristics
     */
    static func productGravitySpriteNode(_ product:Product) -> ProductSKSpriteNode {
        let productNode = ProductSKSpriteNode(product)
        productNode.physicsBody?.mass = CGFloat(C.Physics[String(describing:product)]!["mass"]!)
        productNode.physicsBody?.restitution = CGFloat(C.Physics[String(describing:product)]!["restitution"]!)
        return productNode
    }
    
    /**
     Creates a Shop Scene
     
     @return The shop scene
     */
    static func shopScene()->ShopScene {
        let scene = SKScene(fileNamed: C.ShopScene)!
        scene.scaleMode = .aspectFill
        return scene as! ShopScene
    }
}
