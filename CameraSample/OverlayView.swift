//
//  OverlayView.swift
//  CameraSample
//
//  Created by Mizugaki on 2015/08/10.
//  Copyright (c) 2015年 TAMA PROJECT. All rights reserved.
//

import UIKit

class OverlayView: UIView {

    var contentView: UIView!

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    // Retake/UseVideoを使えるようにする
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return false
    }
}
