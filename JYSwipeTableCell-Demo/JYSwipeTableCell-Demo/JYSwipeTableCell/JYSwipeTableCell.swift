//
//  JYSwipeTableCell.swift
//  JYSwipeTableCell-Demo
//
//  Created by wei_jingyun on 15/7/13.
//  Copyright © 2015年 wei_jingyun. All rights reserved.
//

import UIKit

class JYSwipeTableCell: UITableViewCell {
    static var leftButtons : [SwipeButton]?
    static var rightButtons : [SwipeButton]?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(scrollView)
        scrollView.addSubview(leftView)
        scrollView.addSubview(rightView)
        scrollView.addSubview(view)
        scrollView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.all, v: self))
        leftView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unright, v: scrollView).width(leftView.wide))
        view.ff_edgesView(UIedgeView().top(scrollView , c: 0).bottom(scrollView, c: 0).left(leftView, c: 0).right(rightView, c: 0).size(scrollView))
        rightView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unleft, v: scrollView).width(rightView.wide))
        
        prepareScrollView()
    }
    
    private func prepareScrollView(){
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint(x: 100, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView = UIScrollView()
    lazy var leftView : SwipeView = SwipeView()
    lazy var rightView : SwipeView = SwipeView()
    lazy var view = UIView()
}

extension JYSwipeTableCell : UIScrollViewDelegate {

//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        let px = scrollView.contentOffset.x
//    }
    
    @objc internal func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let px = scrollView.contentOffset.x
        let leftWide = leftView.wide
        let rightWide = rightView.wide
        var setx = -1 as CGFloat
        
        if leftWide != 0 && px < leftWide {
            setx = px > leftWide * 0.5 ? leftWide : 0
        }
        if  rightWide != 0 && px > leftWide {
            setx = px > (leftWide + rightWide * 0.5) ? (leftWide + rightWide) : leftWide
        }
        UIView.animateWithDuration(0.2) { () -> Void in
            scrollView.contentOffset.x = setx
        }
    }
 
}

class SwipeView : UIView {
    var wide = 100 as CGFloat
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
        let buttons = JYSwipeTableCell.leftButtons
        
        if buttons == nil {
            return
        }
        
        for but in buttons! {
            addSubview(but)
        }
        
        self.ff_HorizontalTile(buttons!, insets: UIEdgeInsetsZero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SwipeButton : UIButton {
    class func button (imageName: String, highlightedImageName: String?) -> SwipeButton {
        let but = SwipeButton(type: UIButtonType.Custom)
        but.setImage(UIImage(named: imageName), forState: UIControlState.Normal);
        let hImageName = highlightedImageName ?? imageName + "_highlighted"
        but.setImage(UIImage(named: hImageName), forState: UIControlState.Highlighted)
        but.sizeToFit()
        return but
    }
    
    class func button (text: String, textFont: CGFloat , backgroundColor : UIColor)  -> SwipeButton {
        let but = SwipeButton(type: UIButtonType.Custom)
        but.setTitle(text, forState: UIControlState.Normal)
        but.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        but.backgroundColor = backgroundColor
        return but
    }

}