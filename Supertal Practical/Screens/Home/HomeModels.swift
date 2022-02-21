//
//  HomeModels.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//


import UIKit

enum Home {
    
    // MARK: Use cases
    enum UserList {
        struct Request {
            let path:String
        }
        
        struct Response {
            var userDetails: [UserListModel]
        }
        
        struct ViewModel {
            var userDetails: [UserListModel]
        }
    }
}
