//
//  ViewController.swift
//  Demo
//
//  Created by Tomoya Hayakawa on 2016/10/29.
//  Copyright © 2016年 simorgh. All rights reserved.
//

import APIKit
import UIKit
import Twifter
import SafariServices

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        sendTwitterOAuthRequest()
    }

    func sendTwitterOAuthRequest() {
        let callbackURL = URL(string: "twifter://twitter-oauth-callback-success")!
        Twifter.authentication(viewController: self, callbackURL: callbackURL, handler: { result in
            switch result {
            case .success(let token):
                print("success!!!")
                let twifter = Twifter(accessToken: token)
                print(twifter)

            case .failure(let error):
                print(error)
            }
        })
    }

}


extension ViewController: SFSafariViewControllerDelegate {

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }

}
