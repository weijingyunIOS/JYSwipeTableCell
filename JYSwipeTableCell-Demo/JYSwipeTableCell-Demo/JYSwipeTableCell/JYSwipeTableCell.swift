//
//  JYSwipeTableCell.swift
//  JYSwipeTableCell-Demo
//
//  Created by wei_jingyun on 15/7/13.
//  Copyright © 2015年 wei_jingyun. All rights reserved.
//

import UIKit

class JYSwipeTableCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(scrollView)
        scrollView.addSubview(leftView)
        scrollView.addSubview(rightView)
        scrollView.addSubview(view)
        scrollView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.all, v: self))
        leftView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unright, v: scrollView).width(100))
        view.ff_edgesView(UIedgeView().top(scrollView , c: 0).bottom(scrollView, c: 0).left(leftView, c: 0).right(rightView, c: 0).size(scrollView))
        rightView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unleft, v: scrollView).width(100))
        
        view.backgroundColor = UIColor.purpleColor()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var leftView : UIView = SwipeView()
    lazy var rightView : UIView = SwipeView()
    lazy var scrollView = UIScrollView()
    lazy var view = UIView()
    
}

private class SwipeView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}