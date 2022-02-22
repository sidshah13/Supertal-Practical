//
//  Indicator.swift
//  Supertal Practical
//
//  Created by Sid Shah on 22/02/22.
//  Copyright © 2022 SidSha. All rights reserved.
//

import Foundation
import UIKit
import Reachability

public class Indicator {
    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()
    private init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .red
    }
    func showIndicator() {
        DispatchQueue.main.async( execute: {
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            window?.addSubview(self.blurImg)
            window?.addSubview(self.indicator)
        })
    }
    func hideIndicator() {
        DispatchQueue.main.async( execute: {
            self.blurImg.removeFromSuperview()
            self.indicator.removeFromSuperview()
        })
    }
}
class ConnectionManager {
    static let shared = ConnectionManager()
    private init () {}
    func hasConnectivity() -> Bool {
        do {
            let reachability: Reachability = try Reachability()
            let networkStatus = reachability.connection
            
            switch networkStatus {
            case .unavailable:
                return false
            case .wifi, .cellular:
                return true
            case .none:
                return false
            }
        } catch {
            return false
        }
    }
}
