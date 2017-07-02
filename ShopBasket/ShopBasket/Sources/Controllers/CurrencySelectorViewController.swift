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
    public var currencyViewModel:CurrencyViewModel?
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
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath)
        
        cell.textLabel!.text = self.currencyViewModel!.currencyCode(index: indexPath.row)
        print(self.currencyViewModel!.currencyRate(index: indexPath.row))
        // cell.detailTextLabel!.text = "\(self.currencyViewModel!.currencyRate(index: indexPath.row))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let c = self.currencyViewModel {
            return c.exchangesCount
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let handler = self.onSelected {
            handler(self.currencyViewModel!.currencyCode(index: indexPath.row))
        }
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - IBActions
    @IBAction func onCloseButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
