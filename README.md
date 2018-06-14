# CoinbasePro

[![Build Status](https://travis-ci.org/cocojoe/CoinbasePro.svg?branch=master)](https://travis-ci.org/cocojoe/CoinbasePro)
[![Code Coverage](https://codecov.io/gh/cocojoe/CoinbasePro/branch/master/graph/badge.svg)](https://codecov.io/gh/cocojoe/CoinbasePro)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat-square)

CoinbasePro is a modern, lightweight Swift SDK that lets you seamlessly integrate with the [Coinbase Pro](https://pro.coinbase.com) Trading Platform API. 
> Disclaimer: This is an *unofficial* SDK and not affiliated with Coinbase in anyway. 
> Would be cool to get some feedback through from their Engineers :]
> 
> This started as mini side project to build an iOS App for managing my own trades while travelling. However, I thought it might be nice to turn it into an Open Source Framework as I couldn't find an awesome Swift one...sAlthough my time is limited on this.

## Features

- Extensive Functional Testing
- Full Code Coverage
- Chainable Requests
- Plugin your own Network Layer
- Plugin your own Logging Layer
- Documented Public API

## Getting Started

There is no official release yet as there is a lot left to implement and the Public API is still open to change. However, for those brave pioneers please proceed with caution.

If you are interested in the current state of development, please see the [Project Plan](https://github.com/cocojoe/CoinbasePro/projects/1)

### Prerequisites

- iOS 10+
- Xcode 9.0
- Swift 4.1

### Installing

#### Carthage

If you are using Carthage, add the following lines to your `Cartfile`:

```ruby
github "cocojoe/CoinbasePro" "master"
```

Then run `carthage bootstrap --platform iOS`.

> For more information about Carthage usage, check [their official documentation](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos).

#### Cocoapods

> On the Todo List

## Getting started

First import the CoinbasePro Framework:

```swift
import CoinbasePro
```

Next, initialize the CoinbasePro object:

```swift
let coinbase = CoinbasePro(withAPIKey: apiKey, secret: apiSecret, phrase: apiPhrase, baseURL: apiBaseURL)
```
> If you don't specify the `baseURL` it will automatically be set to the Live GDAX API. I would recommend using the Sandbox.

Then try retrieving a list of the users trading accounts:

```swift
coinbase.accounts.list { error, accounts in
    guard error == nil else {
        return print(error ?? "")
    }

    // Check we accounts to display
    guard let accounts = accounts, !accounts.isEmpty else {
        return print("No Accounts Available")
    }

    // Show all accounts
    accounts.forEach { print($0) }
}
```


## Little John

If you have checked out the repo, you will see there is an Application called `Little John`, a little homage to [Robin Hood](https://en.wikipedia.org/wiki/Robin_Hood_(1973_film)) and [Robinhood](https://robinhood.com/) the awesome trading app.

It features basic usage of the existing functionality. By default it will try to read a `Config.plist` from the project root. The format is as follows:

```plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>APIKey</key>
	<string>YOUR API KEY</string>
	<key>APISecret</key>
	<string>YOUR API SECRET</string>
	<key>APIPhrase</key>
	<string>YOUR API PHRASE</string>
	<key>APIBaseURL</key>
	<string>https://api-public.sandbox.gdax.com</string>
</dict>
</plist>
```

Would love to expand this into something much nicer. However, the focus is the SDK for now.

## Contributing

### Developers

Contributions are always welcome, please feel free to create a PR that is in keeping with the existing code style and includes tests.

### Sponsors / Donations

If you would like to contribute some ETH or BTC that's also cool. Anything over >= 1 BTC. I'll add you to this list of sponsors.

- __BTC:__ 3Lq2BFUitGyfqUGrQYVkKp1mYi1aC3MqPu
- __ETH:__ 0x289C3FFd889062D525456658Bb3Cd2F4bDD15110

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/cocojoe/CoinbasePro/tags). 

## Authors

- **Martin Walsh**
  - __GitHub:__ [cocojoe](https://github.com/cocojoe)
  - __Twitter:__ [martin64k](https://twitter.com/martin64k)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* [Satoshi Nakamoto](https://en.wikipedia.org/wiki/Satoshi_Nakamoto)
* [Vitalik Buterin](https://twitter.com/VitalikButerin)
* [Coinbase](https://www.coinbase.com/)
