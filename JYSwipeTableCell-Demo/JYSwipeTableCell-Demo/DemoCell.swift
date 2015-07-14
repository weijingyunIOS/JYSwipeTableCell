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
        // 所有控件应该添加到 View 上
        view.addSubview(label)
        label.numberOfLines = 0
        label.ff_edgesView(UIedgeView().center(view))
        label.font = UIFont.systemFontOfSize(18)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label = UILabel()
}
