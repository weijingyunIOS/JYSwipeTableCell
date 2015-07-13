//
//  JYSwipeTableCell.swift
//  JYSwipeTableCell-Demo
//
//  Created by wei_jingyun on 15/7/13.
//  Copyright © 2015年 wei_jingyun. All rights reserved.
//

import UIKit

class JYSwipeTableCell: UITableViewCell , SwipeViewDelegate{
    static var leftButtons : [SwipeButton]?
    static var rightButtons : [SwipeButton]?
    
    func SwipeViewbutClick(but: SwipeButton) {
        but.swipeButtonClick!(but: but , cell : self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(backView)
        backView.addSubview(leftView)
        backView.addSubview(rightView)
        backView.addSubview(view)
        backView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.all, v: self).leftSet(-leftView.wide).rightSet(rightView.wide))
        leftView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unright, v: backView).width(leftView.wide))
        view.ff_edgesView(UIedgeView().top(backView , c: 0).bottom(backView, c: 0).left(leftView, c: 0).right(rightView, c: 0))
        rightView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unleft, v: backView).width(rightView.wide))
        
        preparebackView()
        leftView.delegate = self
        rightView.delegate = self
    }
    
    private func preparebackView(){
      
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView = UIView()
    lazy var leftView : SwipeView = SwipeView(frame: CGRectZero, left: true)
    lazy var rightView : SwipeView = SwipeView(frame: CGRectZero, left: false)
    lazy var view = UIView()
}



// 代理协议
protocol SwipeViewDelegate: NSObjectProtocol {
    func SwipeViewbutClick(but : SwipeButton)
}

class SwipeView : UIView {
    var wide = 0 as CGFloat
    weak var delegate : SwipeViewDelegate?
    
     init(frame: CGRect , left : Bool ) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueColor()
        let buttons = left ? JYSwipeTableCell.leftButtons : JYSwipeTableCell.rightButtons
        
        if buttons == nil {
            return
        }
        
        var buts = [SwipeButton]()
        var left : UIView = self
        for but in buttons! {
            let butCopy = but.copy() as! SwipeButton
            addSubview(butCopy)
            buts.append(butCopy)
            wide += butCopy.frame.width
            butCopy.ff_edgesView(UIedgeView().top(self, c: 0).left(left, c: 0).bottom(self, c: 0))
            left = butCopy
            butCopy.addTarget(self, action: "swipeButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        buts.last?.ff_edgesView(UIedgeView().right(self, c: 0))
       
    }

    func swipeButtonClick(but : SwipeButton){
        delegate?.SwipeViewbutClick(but)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK : SwipeButton
class SwipeButton : UIButton , NSCopying  {
    
    var swipeButtonClick : ((but : SwipeButton , cell : JYSwipeTableCell) -> ())?
    
    func setButClick(swipeButtonClick : (but : SwipeButton , cell : JYSwipeTableCell) -> ()){
        self.swipeButtonClick = swipeButtonClick
    }

    class func button(image: UIImage? = nil , backgroundImage : UIImage? = nil, backgroundColor : UIColor? = nil , text: String? = nil , textFont: UIFont? = nil, textcolor : UIColor? = nil ) -> SwipeButton {
        let but = SwipeButton(type: UIButtonType.Custom)
        but.setImage(image, forState: UIControlState.Normal)
        but.setBackgroundImage(backgroundImage, forState: UIControlState.Normal)
        but.backgroundColor = backgroundColor
        but.setTitle(text, forState: UIControlState.Normal)
        but.titleLabel?.font = textFont
        but.setTitleColor(textcolor, forState: UIControlState.Normal)
    
        but.adjustsImageWhenHighlighted = false
        but.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        but.sizeToFit()
        return but
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject{

        let but = SwipeButton.button(imageForState(UIControlState.Normal), backgroundImage: backgroundImageForState(UIControlState.Normal), backgroundColor: backgroundColor, text: titleForState(UIControlState.Normal), textFont: titleLabel?.font, textcolor: titleColorForState(UIControlState.Normal))
        but.swipeButtonClick = self.swipeButtonClick
        return but
    }
}