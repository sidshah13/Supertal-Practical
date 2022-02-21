//
//  HomeWorker.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright (c) 2022 SidSha. All rights reserved.
//

import UIKit
import Alamofire
class HomeWorker {
    
    func getUserDetails(request:  String ,completionHandler: @escaping ([UserListModel]) -> Void) {
        var arrUser = [UserListModel]()
        if let url = URL(string: request) {
            AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil, interceptor: nil, requestModifier: nil).responseJSON { response in
                switch response.result{
                case .success(let value):
                    
                    if let jsonDic = value as? [Any] {
                        for obj in jsonDic {
                            let dic = obj as! [String: String]
                            let objModel = UserListModel(userName: dic["name"] ?? "", userImage: dic["avatar"] ?? "")
                            arrUser.append(objModel)
                        }
                    }
                    completionHandler(arrUser)
                    break
                    
                case .failure(let error):
                    print(error)
                    completionHandler(arrUser)
                    break
                }
            }
        } else {
            completionHandler(arrUser)
        }
    }
    func doSomeWork() {
        
    }
//    
//    func doSomeOtherWork() {
//
//    }
}
