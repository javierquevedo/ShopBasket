//
//  ShopViewController.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 01.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let rateService:JSONRateService = JSONRateService()
    var currencyViewModel :CurrencyViewModel?

    @IBOutlet weak var currenciesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rateService.start { (currency, status, error) in
            self.currencyViewModel = CurrencyViewModel(currency: currency)
            DispatchQueue.main.async(execute: { () -> Void in
                //self.currenciesTableView.reloadData()
            })
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

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        cell.textLabel!.text = self.currencyViewModel!.currencyCode(index: indexPath.row)
        print(self.currencyViewModel!.currencyRate(index: indexPath.row))
       // cell.detailTextLabel!.text = "\(self.currencyViewModel!.currencyRate(index: indexPath.row))"
        return cell
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = self.currencyViewModel {
                return c.exchangesCount
        }else {
            return 0
        }
    }
    
}

