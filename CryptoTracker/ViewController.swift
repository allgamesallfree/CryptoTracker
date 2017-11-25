//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Maxwell Stein on 9/23/17.
//  Copyright © 2017 Maxwell Stein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var priceStackViews: [PriceStackView]!
    var currencies: [CurrencyType] = [.btc, .eth, .ltc]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (i, priceStackView) in priceStackViews.enumerated() {
            priceStackView.setValues(for: currencies[i])
        }
    }
    
}
