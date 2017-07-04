//
//  ShopSKNodeFactory.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 04.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import SpriteKit

struct ShopSKNodeFactory {
    
    static func productGravitySpriteNode(_ product:Product) -> ProductSKSpriteNode {
        let productNode = ProductSKSpriteNode(product)
        productNode.physicsBody?.mass = CGFloat(C.Physics[String(describing:product)]!["mass"]!)
        productNode.physicsBody?.restitution = CGFloat(C.Physics[String(describing:product)]!["restitution"]!)
        return productNode
    }
    
    static func shopScene()->ShopScene {
        let scene = SKScene(fileNamed: C.ShopScene)!
        scene.scaleMode = .aspectFill
        return scene as! ShopScene
    }
}
