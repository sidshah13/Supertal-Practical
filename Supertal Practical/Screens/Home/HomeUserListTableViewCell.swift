//
//  HomeUserListTableViewCell.swift
//  Supertal Practical
//
//  Created by Sid Shah on 21/02/22.
//  Copyright © 2022 SidSha. All rights reserved.
//

import UIKit
import SDWebImage
class HomeUserListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgUserProfile.contentMode = .scaleAspectFill
        self.imgUserProfile.backgroundColor = .random()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUserData(_ obj: UserListModel) {
        self.lblUserName.text = obj.userName
        let imgUrl = URL(string:  obj.userImage)
        let placeHolderImage =  UIImage(systemName: "userloading")
        self.imgUserProfile.sd_setImage(with: imgUrl,
                                        placeholderImage: placeHolderImage)
    }
    
}
