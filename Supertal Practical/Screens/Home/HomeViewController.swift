//
//  HomeViewController.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//


import UIKit

protocol HomeDisplayLogic: AnyObject
{
    func displayUserList(viewModel: Home.UserList.ViewModel)
//    func displaySomethingElse(viewModel: Home.SomethingElse.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    @IBOutlet weak var tblUserList: UITableView!
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var arrUsers = [UserListModel]()
    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
//
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblUserList.register(UINib(nibName: "HomeUserListTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeUserListTableViewCell")
        self.tblUserList.delegate = self
                self.tblUserList.dataSource = self
        fetchUserDataFromServer()
//        doSomethingElse()
    }
    
    // MARK: - receive events from UI
    
    //@IBOutlet weak var nameTextField: UITextField!
//
//    @IBAction func someButtonTapped(_ sender: Any) {
//
//    }
//
//    @IBAction func otherButtonTapped(_ sender: Any) {
//
//    }
    
    // MARK: - request data from HomeInteractor

    func fetchUserDataFromServer() {
        let request = Home.UserList.Request(path: baseURL+userData)
        interactor?.FetchUserList(request: request)
    }
//
//    func doSomethingElse() {
//        let request = Home.SomethingElse.Request()
//        interactor?.doSomethingElse(request: request)
//    }

    // MARK: - display view model from HomePresenter

    func displayUserList(viewModel: Home.UserList.ViewModel) {
        //nameTextField.text = viewModel.name
        DispatchQueue.main.async {
            self.arrUsers.removeAll()
            self.arrUsers = viewModel.userDetails
            self.tblUserList.reloadData()
        }
    }
//
//    func displaySomethingElse(viewModel: Home.SomethingElse.ViewModel) {
//        // do sometingElse with viewModel
//    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeUserListTableViewCell") as? HomeUserListTableViewCell
        cell?.setUserData(self.arrUsers[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToUserDetailScreen()
    }
    
}
