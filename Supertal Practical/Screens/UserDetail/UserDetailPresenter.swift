//
//  UserDetailPresenter.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit

protocol UserDetailPresentationLogic {
    func presentUserDetail(response: UserDetail.userDetail.Response)
}

class UserDetailPresenter: UserDetailPresentationLogic {
    weak var viewController: UserDetailDisplayLogic?

    // MARK: Parse and calc respnse from UserDetailInteractor
    // and send simple view model to UserDetailViewController to be displayed

    func presentUserDetail(response: UserDetail.userDetail.Response) {
        let viewModel = UserDetail.userDetail.ViewModel(userDetail: response.userDetail)
        viewController?.displayUserDetail(viewModel: viewModel)
    }
}
