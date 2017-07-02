//
//  ViewController.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let rateService:JSONRateService = JSONRateService()
    var currency:Currency = Currency(code:"USD", rates:[:])
    
    @IBOutlet weak var currenciesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateService.getCurrency { (currency, status, error) in
            self.currency = currency
            self.currenciesTableView.reloadData()
        }
        //rateService.getCurrency()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onCurrencyTap(_ sender: Any) {
        
    }
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        cell.textLabel!.text = currency.exchanges[indexPath.row]
        return cell
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.rates.count
    }
}

