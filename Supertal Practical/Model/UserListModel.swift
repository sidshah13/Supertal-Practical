//
//  UserListModel.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright © 2022 SidSha. All rights reserved.
//

import Foundation
struct UserListModel: Decodable {
    let userName: String
    let userImage: String
    enum CodingKeys: String, CodingKey {
        case userName = "name"
        case userImage = "avatar"
    }
}
