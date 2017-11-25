//
//  PriceStackView.swift
//  CryptoTracker
//
//  Created by Maxwell Stein on 11/25/17.
//  Copyright © 2017 Maxwell Stein. All rights reserved.
//

import UIKit

class PriceStackView: UIStackView {

    let valueLabel = UILabel()
    let descriptionLabel = UILabel()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        addArrangedSubview(valueLabel)
        addArrangedSubview(descriptionLabel)
        alignment = .fill
        valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        valueLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
    }
    
    func setValues(for currencyType: CurrencyType) {
        descriptionLabel.text = currencyType.name + " Price"
        
        currencyType.requestValue { (value) in
            DispatchQueue.main.async {
                guard let value = value else {
                    self.valueLabel.text = "Failed"
                    return
                }
                self.valueLabel.text = value.formattedCurrencyString
            }
        }
    }
    
}

private extension NSNumber {
    
    /// Takes an optional NSNumber and converts it to USD String
    ///
    /// - Parameter value: The NSNumber to convert to a USD String
    /// - Returns: The USD String or nil in the case of failure
    var formattedCurrencyString: String? {
        /// Construct a NumberFormatter that uses the US Locale and the currency style
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        
        // Ensure the value is non-nil and we can format it using the numberFormatter, if not return nil
        guard let formattedCurrencyAmount = formatter.string(from: self) else {
            return nil
        }
        return formattedCurrencyAmount
    }
    
}
