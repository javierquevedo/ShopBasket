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
    var shopScene:ShopScene?
    var shopViewModel:ShopViewModel?
    
    // MARK: - IBOutlets
    @IBOutlet weak var currencyBarButton: UIBarButtonItem!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var noInternetView: UIStackView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // The Rate service provides updates on the currency exchange rates periodically
        rateService.start { (currency, status, error) in
            if var s = self.shopViewModel {
                s.set(currency: currency)
            }else{
                self.shopViewModel = ShopViewModel(currency)
            }
            self.noInternetView.isHidden = status == .success ? true : false
            self.updatePrice()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rateService.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CurrencySelectorViewController{
            destination.shopViewModel = self.shopViewModel
            destination.onSelected = { (code:String) in
                self.shopViewModel?.currentCode = code
                self.currencyBarButton.title = code
                self.updatePrice()
            }
        }
        if segue.identifier ==  C.ShopSpriteKidEmbeddedSegueId{
            if let skView = segue.destination.view as! SKView? {
                self.shopScene = ShopSKNodeFactory.shopScene()
                skView.presentScene(self.shopScene)
                skView.ignoresSiblingOrder = true
            }
        }
    }
    
    // MARK: - Private Methods
    func updatePrice() {
         DispatchQueue.main.async {
            self.valueLabel?.text = self.shopViewModel?.totalPrice()
            self.currencyLabel?.text = self.shopViewModel?.currentCode
        }
    }
    
    func addProduct(_ product:Product) {
        self.shopViewModel?.addItem(product)
        self.shopScene?.addProduct(product, touchHandler:self.removeProduct)
        self.updatePrice()
    }
    
    func removeProduct(_ product:Product) {
        self.shopViewModel?.removeItem(product)
        self.updatePrice()
    }
    
    // MARK: - IBActions
    @IBAction func onCurrencyButtonTapped(_ sender: Any) {
        if (shopViewModel != nil) {
            performSegue(withIdentifier: C.CurrencySelectorModalSegueId, sender: self)
        }
    }
    
    @IBAction func onMilkButtonTapped(_ sender: Any) {
        self.addProduct(.milk)
    }
    
    @IBAction func onBeansButtonTapped(_ sender: Any) {
        self.addProduct(.beans)
    }
    @IBAction func onEggsButtonTapped(_ sender: Any) {
        self.addProduct(.eggs)
    }
    
    @IBAction func onPeasButtonTapped(_ sender: Any) {
        self.addProduct(.peas)
    }

    // MARK: View
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return [.portrait, .portraitUpsideDown]
    }
}

