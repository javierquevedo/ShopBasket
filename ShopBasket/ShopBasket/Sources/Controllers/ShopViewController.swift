//
//  ShopViewController.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import UIKit
import SpriteKit

class ShopViewController: UIViewController {
   
    let rateService:JSONRateService = JSONRateService()
    var currencyViewModel :CurrencyViewModel?

    @IBOutlet weak var currencyBarButton: UIBarButtonItem!
    @IBAction func onCurrencyButtonTapped(_ sender: Any) {
        if (currencyViewModel != nil) {
            performSegue(withIdentifier: "CurrencySelectorModal", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // The Rate service provides updates on the currency exchange rates periodically
        rateService.start { (currency, status, error) in
            if let c = self.currencyViewModel {
                c.currency = currency
            }else{
                self.currencyViewModel = CurrencyViewModel(currency: currency)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rateService.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CurrencySelectorViewController{
            destination.currencyViewModel = self.currencyViewModel
            destination.onSelected = { (code:String) in
                self.currencyViewModel?.currentCode = code
                self.currencyBarButton.title = code
            }
        }
        
        if segue.identifier == "ShopSpriteKitSegue" {
            if let skView = segue.destination.view as! SKView? {
                // Load the SKScene from 'GameScene.sks'
                if let scene = SKScene(fileNamed: "ShopScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    skView.presentScene(scene)
                }
                
                skView.ignoresSiblingOrder = true
                
                skView.showsFPS = true
                skView.showsNodeCount = true
            }

        }
    }
}

