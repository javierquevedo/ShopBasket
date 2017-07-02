//
//  ShopViewController.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {
   
    let rateService:JSONRateService = JSONRateService()
    var currencyViewModel :CurrencyViewModel?

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
        rateService.start { (currency, status, error) in
            if let c = self.currencyViewModel {
            self.currencyViewModel = CurrencyViewModel(currency: currency, code: c.currentCode)
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
            }
        }
    }

    
}

