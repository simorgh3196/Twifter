# Twifter

[![SwiftVersion](https://img.shields.io/badge/Swift-3.0.2-blue.svg?style=flat)](https://github.com/apple/swift)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/apple/swift)
[![Platform](https://img.shields.io/badge/platform-iOS-green.svg?style=flat)](https://github.com/apple/swift)
[![Build Status](https://travis-ci.org/simorgh3196/Twifter.svg?branch=master)](https://travis-ci.org/simorgh3196/Twifter)

### :exclamation: This is a beta version!

## Task
- [ ] Twitter OAuth Authentication
  - [x] OAuth
  - [ ] iOS internal twitter account
  - [ ] App Only Authentication
- [ ] Twitter REST APIs
- [ ] Installation
  - [x] Cocoapods
  - [ ] Carthage
  - [ ] SwiftPackageManager
- [ ] Document
- [ ] Platform
  - [x] iOS
  - [ ] Mac
  - [ ] Linux
  - [ ] tvOS
  - [ ] watchOS

## Requirements
Xcode8.2, Swift 3.0.2  
iOS 9.0 or later

## Installation

### Cocoapods
```
pod 'Twifter', '~> 0.0.2' 
```

<!-- 
## Carthage
```
github 'simorgh3196/Twifter'
```
-->

## Setup
- Set `URL Types` in `Info.plist`
- Set ConsumerToken, Secret and OAuth callback handler in `AppDeleagte.swift`
```swift
import UIKit
import Twifter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Set consumerToken and consumerSecret
        Twifter.registerConsumerKey(token: "*************************",
                                    secret: "**************************************************")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        // Set handler of twitter oauth callback
        Twifter.handleOpenURL(url: url)

        return true
    }

}
```

## Usage

### OAuth Authentication
callbackURL is defined by `URL Types` in `Info.plist`
```swift
let callbackURL = URL(string: "twifter://")!
Twifter.authentication(viewController: self, callbackURL: callbackURL, handler: { result in
    switch result {
    case .success(let accessToken):
        print("success!!!")
        print("AccessToken is " + accessToken)

    case .failure(let error):
        print(error)
    }
})
```

### Get Tweets
```swift
let twifter = Twifter(accessToken: accessToken)
twifter.getTimeline { tweets in
  print(tweets)
}
```

## Document

## Contributing
Bug reports and pull requests are welcome on GitHub at [https://github.com/simorgh3196/Twifter](https://github.com/simorgh3196/Twifter).

## License
The module is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
