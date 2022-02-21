//
//  UserDetailRouter.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit

@objc protocol UserDetailRoutingLogic {
}

protocol UserDetailDataPassing {
    var dataStore: UserDetailDataStore? { get }
}

class UserDetailRouter: NSObject, UserDetailRoutingLogic, UserDetailDataPassing {
    weak var viewController: UserDetailViewController?
    var dataStore: UserDetailDataStore?

// MARK: Routing (navigating to other screens)
// ADD method FOr Routing

// MARK: Navigation to other screen

// MARK: Passing data to other screen

}
