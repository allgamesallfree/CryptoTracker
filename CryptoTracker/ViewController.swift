//
//  ViewController.swift
//  CryptoTracker
//
//  Created by Maxwell Stein on 9/23/17.
//  Copyright © 2017 Maxwell Stein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var etherValueLabel: UILabel!

    /// The CryptoCompare API URL here returns the value of 1 ETH in USD
    let apiURL = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Safely unwrap the API URL since it could be nil
        guard let apiURL = apiURL else {
            return
        }

        // Make the GET request for our API URL to get the value NSNumber
        makeValueGETRequest(url: apiURL) { (value) in

            // Must update the UI on the main thread since makeValueGetRequest is a background operation
            DispatchQueue.main.async {
                // Set the etherValueLabel with the formatted USD value or "Failed" in the case of failure
                self.etherValueLabel.text = self.formatAsCurrencyString(value: value) ?? "Failed"
            }
        }
    }
    
    /// Takes an API URL and performs a GET request on it to try to get back an NSNumber
    ///
    /// - Parameters:
    ///   - url: The API URL to perform the GET request with
    ///   - completion: Returns the value as an NSNumber, or nil in the case of failure
    private func makeValueGETRequest(url: URL, completion: @escaping (_ value: NSNumber?) -> Void) {
        let request = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                completion(nil)
                print(error?.localizedDescription ?? "")
                return
            }
            
            do {
                // Unwrap the JSON dictionary and read the USD key which has the value of Ethereum
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let value = json["USD"] as? NSNumber else {
                        completion(nil)
                        return
                }
                completion(value)
            } catch  {
                // If we couldn't serialize the JSON set the value in the completion as nil and print the error
                completion(nil)
                print(error.localizedDescription)
            }
        }
        
        request.resume()
    }
    
    /// Takes an optional NSNumber and converts it to USD String
    ///
    /// - Parameter value: The NSNumber to convert to a USD String
    /// - Returns: The USD String or nil in the case of failure
    private func formatAsCurrencyString(value: NSNumber?) -> String? {
        /// Construct a NumberFormatter that uses the US Locale and the currency style
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency

        // Ensure the value is non-nil and we can format it using the numberFormatter, if not return nil
        guard let value = value,
            let formattedCurrencyAmount = formatter.string(from: value) else {
                return nil
        }
        return formattedCurrencyAmount
    }
}

