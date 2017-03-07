//
//  JZExtensions.swift
//  JZYouTube_Demo
//
//  Created by jiong23 on 2017/3/7.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import UIKit

extension UIColor {
    class func rbg(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        let color = UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
        return color
    }
}

