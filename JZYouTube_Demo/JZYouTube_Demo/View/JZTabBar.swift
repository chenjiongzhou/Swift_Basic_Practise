//
//  JZTabBar.swift
//  JZYouTube_Demo
//
//  Created by jiong23 on 2017/3/7.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import UIKit

protocol JZTabBarDelagete {
    func didSelectedItem(atIndex: Int)
}

class JZTabBar: UIView,
                UICollectionViewDelegate,
                UICollectionViewDataSource,
                UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
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
    var delegate : JZTabBarDelagete?
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! JZTaBarCollectionViewCell
        cell.iconImageView.image = UIImage.init(named: darkItems[indexPath.row])
        if indexPath.row == 0 {
            cell.iconImageView.image = UIImage.init(named: items[0])
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tabBarW = self.frame.width
        let tabBarH = self.frame.height
        return CGSize.init(width: tabBarW / 4, height: tabBarH - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectedItem(atIndex: indexPath.row)
    }
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(JZTaBarCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.backgroundColor = UIColor.rbg(red: 228, green: 34, blue: 24)
        addSubview(self.collectionView)
        addSubview(self.sliderView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Privite Method
//    func setupTabBarItems() {
//        let tabBarW = self.frame.width
//        let tabBarH = self.frame.height
//        for index in 0...3 {
//            let item = UIButton.init(frame: CGRect.init(x: CGFloat(index) * tabBarW, y: 0, width: tabBarW / 4, height: tabBarH))
//            item.setImage(UIImage.init(named: items[index]), for: .normal)
//            item.setImage(UIImage.init(named: darkItems[index]), for: .selected)
//        }
//        
//    }
    
    // MARK: Public Method
    func highlightItem(atIndex: Int)  {
        for index in  0...3 {
            let cell = collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as! JZTaBarCollectionViewCell
            cell.iconImageView.image = UIImage.init(named: darkItems[index])
        }
        let cell = collectionView.cellForItem(at: IndexPath.init(row: atIndex, section: 0)) as! JZTaBarCollectionViewCell
        cell.iconImageView.image = UIImage.init(named: darkItems[atIndex])
    }
    
}

class  JZTaBarCollectionViewCell: UICollectionViewCell {
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let width = (self.contentView.bounds.width - 30) / 2
        iconImageView.frame = CGRect.init(x: width, y: 2, width: 30, height: 30)
        let iconImage = UIImage.init(named: "home")
        iconImageView.image = iconImage?.withRenderingMode(.alwaysTemplate)
        self.contentView.addSubview(iconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
