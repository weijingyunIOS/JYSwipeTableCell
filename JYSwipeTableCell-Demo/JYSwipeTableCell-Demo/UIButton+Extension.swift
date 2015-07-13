//
//  UIButton+Extension.swift
//  Weibo007
//
//  Created by apple on 15/7/2.
//  Copyright © 2015年 heima. All rights reserved.
//

import UIKit

extension UIButton {
    
    // 提示：方法的参数最好不要太多
    convenience init(title: String, imageName: String, fontSize: CGFloat, titleColor: UIColor = UIColor.darkGrayColor()) {
        
        self.init()
        
        setTitle(" " + title, forState: UIControlState.Normal)
        setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        titleLabel?.font = UIFont.systemFontOfSize(fontSize)
        setTitleColor(titleColor, forState: UIControlState.Normal)
    }
}