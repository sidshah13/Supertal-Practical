//
//  UserDetailInteractor.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit

protocol UserDetailBusinessLogic {
    func getUserDetail(request: UserDetail.UserDetailEnum.Request)
}

protocol UserDetailDataStore {
    var userDetail: UserListModel! { get set }
}

class UserDetailInteractor: UserDetailBusinessLogic, UserDetailDataStore {
    var userDetail: UserListModel!
    
    
    var presenter: UserDetailPresentationLogic?
    var worker: UserDetailWorker?
    
    // MARK: Do something (and send response to UserDetailPresenter)

    func getUserDetail(request: UserDetail.UserDetailEnum.Request) {
        worker = UserDetailWorker()
        worker?.userDetail()

        let response = UserDetail.UserDetailEnum.Response(userDetail: userDetail)
        presenter?.presentUserDetail(response: response)
    }
}
