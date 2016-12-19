//
//  SignInBtn.swift
//  Music-Social
//
//  Created by Jonathan Mitchell on 12/19/16.
//  Copyright © 2016 JDM FZJ. All rights reserved.
//

import UIKit

class SignInBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }
}
