//
//  JZTabBar.swift
//  JZYouTube_Demo
//
//  Created by jiong23 on 2017/3/7.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import UIKit

class JZTabBar: UIView,
                UICollectionViewDelegate,
                UICollectionViewDataSource,
                UICollectionViewDelegateFlowLayout {
    
    //MARK: LifeCycle
    
    //MARK: Delegate
    
    //MARK: Properties
    let cellIdentifier = "Cell"
    let darkItems = ["homeDark", "trendingDark", "subscriptionsDark", "accountDark"]
    let items = ["home", "trending", "subscriptions", "account"]
    lazy var sliderView: UIView = {
        let tabBarW = self.frame.width
        let tabBarH = self.frame.height
        let sliderView = UIView.init(frame: CGRect.init(x: 0, y: tabBarH - 5, width: tabBarW / 4, height: 5))
        sliderView.backgroundColor = UIColor.rbg(red: 245, green: 245, blue: 245)
        return sliderView
    }()
    lazy var collectionView: UICollectionView = {
        let tabBarW = self.frame.width
        let tabBarH = self.frame.height
        let layout = UICollectionViewFlowLayout()
        let colletionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 20, width: tabBarW, height: tabBarH - 20), collectionViewLayout: layout)
        colletionView.delegate = self
        colletionView.dataSource = self
        
        return colletionView
    }()
    var delegate : UITabBarDelegate?
    
    //MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) 
//        cell.
        if indexPath.row == 0 {
            
        }
        return cell
    }
    
    
}
