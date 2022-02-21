//
//  HomeInteractor.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//


import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
//    func doSomethingElse(request: Home.SomethingElse.Request)
}

protocol HomeDataStore {
    //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    //var name: String = ""

    // MARK: Do something (and send response to HomePresenter)

    func doSomething(request: Home.Something.Request) {
        worker = HomeWorker()
        worker?.doSomeWork()

        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
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
