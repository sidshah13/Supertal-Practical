//
//  UserDetailViewController.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit
import SDWebImage

protocol UserDetailDisplayLogic: AnyObject
{
    func displayUserDetail(viewModel: UserDetail.userDetail.ViewModel)

}

class UserDetailViewController: UIViewController, UserDetailDisplayLogic {
    var interactor: UserDetailBusinessLogic?
    var router: (NSObjectProtocol & UserDetailRoutingLogic & UserDetailDataPassing)?

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserProfile: UIImageView!
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
        let interactor = UserDetailInteractor()
        let presenter = UserDetailPresenter()
        let router = UserDetailRouter()
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
        
        showUserDetail()
    }

    // MARK: - request data from UserDetailInteractor
    func showUserDetail() {
        let request = UserDetail.userDetail.Request()
        interactor?.getUserDetail(request: request)
    }

    // MARK: - display view model from UserDetailPresenter

    func displayUserDetail(viewModel: UserDetail.userDetail.ViewModel) {
        self.lblUserName.text = viewModel.userDetail.userName
        self.imgUserProfile.sd_setImage(with: URL(string:  viewModel.userDetail.userImage), placeholderImage: UIImage(systemName: "userloading"))
    }
}
