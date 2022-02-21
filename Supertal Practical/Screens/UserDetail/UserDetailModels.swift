//
//  UserDetailModels.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit

enum UserDetail
{
    // MARK: Use cases

    enum userDetail
    {
        struct Request
        {

        }

        struct Response
        {
            var userDetail: UserListModel
        }

        struct ViewModel
        {
            var userDetail: UserListModel
        }
    }
}
