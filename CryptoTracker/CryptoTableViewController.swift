//
//  CryptoTableViewController.swift
//  CryptoTracker
//
//  Created by Maxwell Stein on 12/13/17.
//  Copyright © 2017 Maxwell Stein. All rights reserved.
//

import UIKit

final class CryptoTableViewController: UITableViewController {

    let currencies: [CurrencyType] = [.btc, .eth, .ltc, .xrp, .xmr, .neo]
    let reuseIdentifier = String(describing: CryptoTableViewCell.self)
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let cryptoTableViewCell = tableViewCell as? CryptoTableViewCell {
            let currencyType = currencies[indexPath.row]
            cryptoTableViewCell.formatCell(withCurrencyType: currencyType)
        }
        
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cryptocurrency Prices"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return "Updated on " + dateString
    }


}

