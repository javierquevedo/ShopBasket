//
//  CurrencySelectorViewController.swift
//  ShopBasket
//
//  Created by Javier Quevedo on 02.07.17.
//  Copyright © 2017 Javier Quevedo. All rights reserved.
//

import UIKit

class CurrencySelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Public Properties
    public var shopViewModel:ShopViewModel?
    public var onSelected:((String)->Void)?
    
    // MARK: - IBOutlets
    @IBOutlet weak var currenciesTableView: UITableView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.currenciesTableView.reloadData()
    }

    // MARK: - Delegation Protocols
    // MARK: TableView
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CurrencyTableViewCell = tableView.dequeueReusableCell(withIdentifier: C.CurrencyCellId, for: indexPath) as! CurrencyTableViewCell
        cell.currencyNameLabel!.text = self.shopViewModel!.currencyCode(index: indexPath.row)
        cell.currencyRateNameLabel!.text = self.shopViewModel!.currencyCode(index: indexPath.row)
        cell.currencyValueLabel!.text = self.shopViewModel?.currencyDisplayRate(index:indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = self.shopViewModel {
            return c.exchangesCount
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let handler = self.onSelected {
            handler(self.shopViewModel!.currencyCode(index: indexPath.row))
        }
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - IBActions
    @IBAction func onCloseButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
