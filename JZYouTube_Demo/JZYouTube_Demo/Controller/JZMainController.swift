//
//  JZMainController.swift
//  JZYouTube_Demo
//
//  Created by jiong23 on 2017/3/7.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import UIKit

class JZMainController: UIViewController,
                        JZTabBarDelagete,
                        UIScrollViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureSubViews()
        
        didSelectedItem(atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Properties
    var views = [UIView]()
    let items = ["Home", "Trending", "Subscriptions", "Account"]
    lazy var tabBar: JZTabBar = {
        let tabBar = JZTabBar.init(frame: CGRect.init(x: 0, y: 0, width: globalVariables.width, height: 64))
        tabBar.delegate = self
        return tabBar
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel.init(frame: CGRect.init(x: 20, y: 5, width: 200, height: 30))
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.text = "Home"
        return titleLabel
    }()
    
    // MARK: - JZTabBarDelagete
    func didSelectedItem(atIndex: Int) {
//         self.collectionView.scrollRectToVisible(CGRect.init(origin: CGPoint.init(x: (self.view.bounds.width * CGFloat(atIndex)), y: 0), size: self.view.bounds.size), animated: true)
    }
    
    // MARK: - JZTabBarDelagete
    func configureSubViews()  {
        //NavigationController Customization
        self.navigationController?.view.backgroundColor = UIColor.rbg(red: 228, green: 34, blue: 24)
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.hidesBackButton = true
        
        //NavigationBar color and shadow
        self.navigationController?.navigationBar.barTintColor = UIColor.rbg(red: 228, green: 34, blue: 24)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.addSubview(self.titleLabel)
        
        self.view.addSubview(self.tabBar)
        
        for title in self.items {
            let storyBoard = self.storyboard!
            let viewController = storyBoard.instantiateViewController(withIdentifier: title)
            self.addChildViewController(viewController)
            viewController.view.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 44)
            viewController.didMove(toParentViewController: self)
            self.views.append(viewController.view)
        }
    }
    
    // MAKR: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = Int(round(scrollView.contentOffset.x / self.view.bounds.width))
        self.titleLabel.text = self.items[scrollIndex]
        self.tabBar.sliderView.frame.origin.x = scrollView.contentOffset.x / 4
        self.tabBar.highlightItem(atIndex: scrollIndex)
    }
}
