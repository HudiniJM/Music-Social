//
//  PostCell.swift
//  Music-Social
//
//  Created by Jonathan Mitchell on 12/23/16.
//  Copyright © 2016 JDM FZJ. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
