//
//  HomeViewController.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit
import Reachability
protocol HomeDisplayLogic: AnyObject {
    func displayUserList(viewModel: Home.UserList.ViewModel)
}
class HomeViewController: UIViewController, HomeDisplayLogic {
    @IBOutlet weak var tblUserList: UITableView!
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    var arrUsers = [UserListModel]()
    var reuseCellId = "HomeUserListTableViewCell"
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
        let cellNib = UINib(nibName: reuseCellId, bundle: nil)
        self.tblUserList.register(cellNib,
                                  forCellReuseIdentifier: reuseCellId)
        self.tblUserList.delegate = self
        self.tblUserList.dataSource = self
        fetchUserDataFromServer()
    }
    // MARK: - request data from HomeInteractor
    func fetchUserDataFromServer() {
        if ConnectionManager.shared.hasConnectivity() {
            Indicator.sharedInstance.showIndicator()
            let request = Home.UserList.Request(path: baseURL+userData)
            interactor?.fetchUserList(request: request)
        } else {
            self.view.toastView(messsage: "Please check Internet Connection")
        }
    }
    // MARK: - display view model from HomePresenter
    func displayUserList(viewModel: Home.UserList.ViewModel) {
        Indicator.sharedInstance.hideIndicator()
        DispatchQueue.main.async {
            self.arrUsers.removeAll()
            self.arrUsers = viewModel.userDetails
            self.tblUserList.reloadData()
        }
    }
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId) as? HomeUserListTableViewCell
        cell?.setUserData(self.arrUsers[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToUserDetailScreen()
    }
}
