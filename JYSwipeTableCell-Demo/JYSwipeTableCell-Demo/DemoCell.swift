//
//  DemoCell.swift
//  JYSwipeTableCell-Demo
//
//  Created by wei_jingyun on 15/7/14.
//  Copyright © 2015年 wei_jingyun. All rights reserved.
//

import UIKit

class DemoCell: JYSwipeTableCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        view.addSubview(<#T##view: UIView##UIView#>)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var label = UILabel()
}
