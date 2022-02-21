//
//  HomeInteractor.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    func FetchUserList(request: Home.UserList.Request)
//    func doSomethingElse(request: Home.SomethingElse.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
    var userList: [UserListModel]? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    var userList: [UserListModel]?
    //var name: String = ""

    // MARK: Do something (and send response to HomePresenter)

    func FetchUserList(request: Home.UserList.Request) {
        worker = HomeWorker()
        worker?.getUserDetails(request: request.path, completionHandler: { arrUser in
            self.userList = arrUser
            let response = Home.UserList.Response(userDetails: arrUser)
            self.presenter?.presentUserList(response: response)
        })
        
        
    }
//
//    func doSomethingElse(request: Home.SomethingElse.Request) {
//        worker = HomeWorker()
//        worker?.doSomeOtherWork()
//
//        let response = Home.SomethingElse.Response()
//        presenter?.presentSomethingElse(response: response)
//    }
}
