//
//  HomePresenter.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.

import UIKit

protocol HomePresentationLogic {
    func presentUserList(response: Home.UserList.Response)
}
class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeDisplayLogic?
    // MARK: Parse and calc respnse from HomeInteractor
    // and send simple view model to HomeViewController to be displayed
    func presentUserList(response: Home.UserList.Response) {
        let viewModel = Home.UserList.ViewModel(userDetails: response.userDetails)
        viewController?.displayUserList(viewModel: viewModel)
    }
}
