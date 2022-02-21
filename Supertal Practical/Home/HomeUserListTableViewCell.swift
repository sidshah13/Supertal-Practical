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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setUserData(_ obj: UserListModel) {
        self.lblUserName.text = obj.userName
        self.imgUserProfile.sd_setImage(with: URL(string: obj.userImage), placeholderImage: UIImage(systemName: "userloading"))
    }
    
}
