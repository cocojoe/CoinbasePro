# CoinbasePro

[![Build Status](https://travis-ci.org/cocojoe/CoinbasePro.svg?branch=master)](https://travis-ci.org/cocojoe/CoinbasePro)
[![Code Coverage](https://codecov.io/gh/cocojoe/CoinbasePro/branch/master/graph/badge.svg)](https://codecov.io/gh/cocojoe/CoinbasePro)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat-square)

CoinbasePro is a modern, lightweight Swift SDK that lets you seamlessly integrate with the [Coinbase Pro](https://pro.coinbase.com) Trading Platform API. 
> Disclaimer: This is an *unofficial* SDK and not affiliated with Coinbase in anyway. 
> Would be cool to get some feedback from their Engineers though :]
> 
> This started as small project to build an iOS App for managing my own trades while travelling. However, I thought it might be nice to turn it into an Open Source Framework, as I couldn't find a good Swift one... 
> Please note this is a hobby project, there are no timeline commitments.

## Features

- Good API Documentation
- Extensive Functional Testing
- Easy to use
- Awesome Code Coverage
- Chainable Requests
- (Todo) Plugin your own Network Layer
- (Todo) Plugin your own Logging Layer

## Getting Started

There is no official release yet as there is a lot left to implement and the Public API is still open to change. However, for those brave pioneers please proceed with caution.

If you are interested in the current state of development, please see the [Project Plan](https://github.com/cocojoe/CoinbasePro/projects/1)

### Prerequisites

- iOS 10+
- Xcode 10.x
- Swift 4.x/5.x

### Installing

#### Carthage

If you are using Carthage, add the following to your `Cartfile`:

```ruby
github "cocojoe/CoinbasePro" "master"
```

Then run `carthage bootstrap --platform iOS`

> For more information about Carthage usage, check [their official documentation](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos).

#### Cocoapods

> Todo, See [Package Manager Card](https://github.com/cocojoe/CoinbasePro/projects/1#card-10441893)

## Getting started

First import the CoinbasePro Framework:

```swift
import CoinbasePro
```

Next, initialize the CoinbasePro object:

```swift
let coinbase = CoinbasePro(withAPIKey: apiKey, secret: apiSecret, phrase: apiPhrase, baseURL: apiBaseURL)
```
> If you don't specify the `baseURL` it will automatically be set to the Live API. I would recommend using the Sandbox API.

Then try retrieving a list of the users trading accounts:

```swift
coinbase.accounts.list { error, result in
    guard error == nil else {
        return print(error ?? "")
    }

    // Check we have a list of accounts 
    guard let accounts = result.account, !accounts.isEmpty else {
        return print("No Accounts Available")
    }

    // Show all accounts
    accounts.forEach { print($0) }
}
```

## Little John

If you have checked out the repo, you will see there is an Application called `Little John`, a homage to [Disney's Robin Hood](https://en.wikipedia.org/wiki/Robin_Hood_(1973_film)) and [Robinhood](https://robinhood.com/) the awesome trading app.

It features basic usage of the current functionality. By default it will try to read a `Credentials.plist` from the project's root folder. 
> Note: It's super insecure to store credential information in a plist, this is only a convenience for myself testing locally :) Do not use
this in a Production Environment ever.

The format should be as follows:

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

## Contributing

### Developers

Contributions are always welcome, please feel free to create a PR that is in keeping with the existing code style and includes tests.

### Sponsors / Donations

If you would like to contribute some ETH or BTC that's also cool. Anything over >= 1 BTC and I'll add you to this list of sponsors.

- __BTC:__ 3Lq2BFUitGyfqUGrQYVkKp1mYi1aC3MqPu
- __ETH:__ 0x289C3FFd889062D525456658Bb3Cd2F4bDD15110

## Versioning

I use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/cocojoe/CoinbasePro/tags). 

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
