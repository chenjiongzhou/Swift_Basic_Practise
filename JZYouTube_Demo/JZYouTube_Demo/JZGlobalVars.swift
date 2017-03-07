//
//  JZGlobalVars.swift
//  JZYouTube_Demo
//
//  Created by jiong23 on 2017/3/7.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import Foundation
import UIKit

struct globalVariables {
    static let urlLink = URL.init(string: "http://mexonis.com/home.json")!
    static let moreURLLink = URL.init(string: "http://mexonis.com/more.json")!
    static let subscriptionsLink = URL.init(string: "http://mexonis.com/subscriptions.json")!
    static let profileLink = URL.init(string: "http://mexonis.com/profile.json")!
    static let videoLink = URL.init(string: "http://mexonis.com/video.json")!
    static let rect = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
    static let width  = UIScreen.main.bounds.width
    static let height: CGFloat =  64
}
