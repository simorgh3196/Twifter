//
//  Twifter.swift
//  Twifter
//
//  Created by Tomoya Hayakawa on 2016/10/29.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import Accounts
import APIKit
import Result
import UIKit
import SafariServices


extension Notification.Name {
    static let twifterOAuthCallback = Notification.Name(rawValue: "TwifterOAuthCallback")
}

struct NotificationInfoKey {
    static let oauthRedirectedURL = "OAuthRedirectedURL"
}


public class Twifter {

    private var credential: Credential


    public init(accessToken: Credential.AccessToken) {
        credential = Credential(accessToken: accessToken)
    }

    public init(acAccount: ACAccount) {
        credential = Credential(acAccount: acAccount)
    }


    public class func registerConsumerKey(token: String, secret: String) {
        Credential.registerConsumerToken(token: token, secret: secret)
    }

    public class func handle(open url: URL) {
        let notification = Notification(name: .twifterOAuthCallback, object: nil, userInfo: [NotificationInfoKey.oauthRedirectedURL: url])
        NotificationCenter.default.post(notification)
    }

    public class func authentication(viewController: UIViewController, callbackURL: URL, handler: @escaping (Result<Credential.AccessToken, SessionTaskError>) -> Void) {
        fetchOAuthRequestToken(callbackURL: callbackURL, handler: { result in
            switch result {
            case let .success(token, url):
                NotificationCenter.default.addObserver(forName: .twifterOAuthCallback, object: nil, queue: .main) { notification in
                    NotificationCenter.default.removeObserver(self, name: .twifterOAuthCallback, object: nil)
                    let vc = viewController.presentedViewController
                    if vc is SFSafariViewController {
                        vc?.dismiss(animated: true)
                    }

                    let url = notification.userInfo![NotificationInfoKey.oauthRedirectedURL] as! URL
                    var verifier: String?
                    URLComponents(string: url.absoluteString)?.queryItems?.forEach { item in
                        if item.name == "oauth_verifier" {
                            verifier = item.value
                        }
                    }
                    guard verifier != nil else {
                        handler(.failure(SessionTaskError.responseError(TwifterError.badOAuthResponse)))
                        return
                    }

                    fetchOAuthAccessToken(accessToken: token, verifier: verifier!, handler: handler)
                }

                let safariViewController = SFSafariViewController(url: url)
                DispatchQueue.main.async {
                    viewController.present(safariViewController, animated: true)
                }

            case .failure(let error):
                handler(.failure(error))
            }
        })
    }

    @discardableResult
    private class func fetchOAuthRequestToken(callbackURL: URL, handler: @escaping (Result<(token: Credential.AccessToken, url: URL), SessionTaskError>) -> Void) -> SessionTask? {
        let request = FetchOAuthRequestToken(credential: Credential(), callbackURL: callbackURL)

        return Session.send(request, handler: handler)
    }

    @discardableResult
    private class func fetchOAuthAccessToken(accessToken: Credential.AccessToken, verifier: String, handler: @escaping (Result<Credential.AccessToken, SessionTaskError>) -> Void) -> SessionTask? {
        let credential = Credential(accessToken: accessToken)
        let request = FetchOAuthAccessToken(credential: credential, verifier: verifier)

        return Session.send(request, handler: handler)
    }

}
