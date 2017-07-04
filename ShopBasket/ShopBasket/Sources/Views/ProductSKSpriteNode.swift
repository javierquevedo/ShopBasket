//
//  ProductSKSpriteNode.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 03.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import SpriteKit

class ProductSKSpriteNode: SKSpriteNode {

    // MARK: - Public properties
    public var touched:((Product)->Void)?
    public var product:Product
    
    
    // MARK: - Initialisation
    init(_ product:Product) {
        self.product = product
        let texture = SKTexture(imageNamed: String(describing: product))
        super.init(texture:texture, color: UIColor.clear, size:texture.size())
        self.physicsBody = SKPhysicsBody.init(texture: texture, size: texture.size())
        self.isUserInteractionEnabled = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) No implementation available")
    }
    
    // MARK: - Event Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let targetNode = atPoint(touch.location(in: self)) as? SKSpriteNode{
            if (targetNode == self) {
                DispatchQueue.main.async {
                    self.touched?(self.product)
                    self.touched = nil
                    self.removeAllActions()
                    self.removeFromParent()
                }
            }
        }
    }
}
