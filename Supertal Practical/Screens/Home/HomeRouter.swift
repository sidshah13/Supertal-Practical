//
//  HomeRouter.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    func routeToUserDetailScreen()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    // MARK: Routing (navigating to other screens)
    func routeToUserDetailScreen() {
        let strVCId = "UserDetailViewController"
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: strVCId) as! UserDetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToUserDetail(source: dataStore!, destination: &destinationDS)
        navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
    // MARK: Navigation to other screen
    
    func navigateToShowOrder(source: HomeViewController, destination: UserDetailViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data to other screen
    func passDataToUserDetail(source: HomeDataStore, destination: inout UserDetailDataStore)
    {
        let selectedRow = viewController?.tblUserList.indexPathForSelectedRow?.row
        destination.userDetail = source.userList?[selectedRow!]
    }
}
    
