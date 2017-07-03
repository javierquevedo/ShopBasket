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
        
        if let ground = self.childNode(withName: "//ground") as? SKSpriteNode {
           print("ground")
        }

        
    }
}
