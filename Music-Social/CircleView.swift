//
//  CircleView.swift
//  Music-Social
//
//  Created by Jonathan Mitchell on 12/22/16.
//  Copyright © 2016 JDM FZJ. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {

        layer.cornerRadius = self.frame.width / 2
    }
}
