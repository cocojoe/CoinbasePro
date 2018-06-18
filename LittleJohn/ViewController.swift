//
//  ViewController.swift
//  LittleJohn
//
//  Created by Martin on 06/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import UIKit
import CoinbasePro

class ViewController: UIViewController {

    var coinbase: CoinbasePro?

    override func viewDidLoad() {
        super.viewDidLoad()
        if  let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: String],
            let apiKey = dict["APIKey"],
            let apiSecret = dict["APISecret"],
            let apiPhrase = dict["APIPhrase"],
            let apiBaseURL = dict["APIBaseURL"] {
            self.coinbase = CoinbasePro(withAPIKey: apiKey, secret: apiSecret, phrase: apiPhrase, baseURL: apiBaseURL)
            self.checkAPI()
        } else {
            print("Config.plist missing, See README for more information.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkAPI() {
        // Do any additional setup after loading the view, typically from a nib.
        guard var cbAccounts = self.coinbase?.accounts else {
            return print("CoinbasePro Not Available")
        }

        // List Accounts
        cbAccounts.list { error, accounts in
            guard error == nil else {
                return print(error ?? "")
            }

            // Check we have some accounts
            guard let accounts = accounts, !accounts.isEmpty else {
                return print("No Accounts Available")
            }

            // Debug Output
            //accounts.forEach { print($0) }

            // Select a Single Account
            let accountID = accounts.first!.id

            // Account Detail
            cbAccounts.retrieve(accountID) { error, account in
                guard error == nil, let account = account else {
                    return print(error ?? "")
                }
                //print(account)
            }

            // Account History
            cbAccounts
                .limit(2)
                .history(accountID) { error, history in
                guard error == nil else {
                    return print(error ?? "")
                }

                // Check we have some history
                guard let history = history, !history.isEmpty else {
                    return print("No History Available")
                }

                print("Total History: \(history.count)")

                history.forEach { print($0) }
            }

            // Account Holds
            cbAccounts.holds(accountID) { error, holds in

                guard error == nil else {
                    return print(error ?? "")
                }

                // Check we have some holds
                guard let holds = holds, !holds.isEmpty else {
                    return print("No Holds Available")
                }

                //holds.forEach { print($0) }
            }

        }
    }

}

