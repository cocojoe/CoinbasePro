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
            fatalError("Config.plist missing, See development section in README")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func checkAPI() {
        // Do any additional setup after loading the view, typically from a nib.
        var accountID: String = ""

        self.coinbase?.accounts().getAccounts { error, accounts in
            guard error == nil, let accounts = accounts else {
                return print(error ?? "No error specified")
            }
            
            accounts.forEach { account in
                print(account)
            }

            // Single Account
            accountID = accounts.first!.id

            self.coinbase?.accounts().getAccount(withID: accountID) { error, account in
                guard error == nil, let account = account else {
                    return print(error ?? "Generic Error")
                }
                print(account)
            }
        }
    }

}

