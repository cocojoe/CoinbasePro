//
//  ViewController.swift
//  LittleJohn
//
//  Created by Martin Walsh on 06/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
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
        } else {
            print("Config.plist missing, See README for more information.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAccount(_ sender: Any) {
        self.demoAccounts()
    }

    @IBAction func btnOrders(_ sender: Any) {
        self.demoOrders()
    }

    // MARK:- Accounts
    private func demoAccounts() {
        // Do any additional setup after loading the view, typically from a nib.
        guard let coinbase = self.coinbase else {
            return print("CoinbasePro Not Available")
        }

        // List Accounts
        coinbase
            .accounts
            .list { error, result in
                guard error == nil else {
                    return print(error ?? "")
                }

                // Check we have accounts
                guard let accounts = result.account, !accounts.isEmpty else {
                    return print("No Accounts Available")
                }

                accounts.forEach { print($0) }

                // Pick First Account
                let accountID = accounts.first!.id

                // Account Detail
                coinbase
                    .accounts
                    .retrieve(accountID) { error, account in
                        guard error == nil, let account = account else {
                            return print(error ?? "")
                        }
                        print(account)
                }

                // Account History
                coinbase
                    .accounts
                    .limit(100)
                    .history(accountID) { error, result in
                        guard error == nil else {
                            return print(error ?? "")
                        }

                        // Check History Available
                        guard let history = result.accountLedger, !history.isEmpty else {
                            return print("No History Available")
                        }
                        history.forEach { print($0) }

                        // Pagination Test
                        if let pagination = result.pagination, let previous = pagination.previous {
                            coinbase
                                .accounts
                                .limit(5)
                                .nextPage(previous)
                                .history(accountID) { error, result in
                                    if let history = result.accountLedger, !history.isEmpty {
                                        history.forEach { print($0) }
                                    }
                            }
                        }
                }

                // Account Holds
                coinbase
                    .accounts
                    .holds(accountID) { error, result in

                        guard error == nil else {
                            return print(error ?? "")
                        }

                        // Check we have some holds
                        guard let holds = result.accountHold, !holds.isEmpty else {
                            return print("No Holds Available")
                        }

                        holds.forEach { print($0) }
                }

        }
    }

    // MARK:- Orders
    private func demoOrders() {

        // Do any additional setup after loading the view, typically from a nib.
        guard let coinbase = self.coinbase else {
            return print("CoinbasePro Not Available")
        }

        // List Orders
        coinbase
            .orders
            .list(withStatus: "open") { error, result in
                guard error == nil else {
                    return print(error ?? "")
                }

                // Check we have accounts
                guard let orders = result.order, !orders.isEmpty else {
                    return print("No Accounts Available")
                }

                orders.forEach { print($0) }
        }


    }

}

