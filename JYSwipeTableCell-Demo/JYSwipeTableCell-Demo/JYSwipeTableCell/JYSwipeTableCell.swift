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
    // 记录打开的cell
    private static var openCell : JYSwipeTableCell?
    
    // left right 的约束  NSLayoutConstraint
    private var leftConstraint : NSLayoutConstraint?
    private var rightConstraint : NSLayoutConstraint?
    
    class func closeEditCell(){
        JYSwipeTableCell.openCell?.closeEditCell()
    }
    
    // MARK: 点击事件
    func SwipeViewbutClick(but: SwipeButton) {
        assert(but.swipeButtonClick != nil, "必须实现SwipeButton的block回调方法")
        but.swipeButtonClick!(but: but , cell : self)
        closeEditCell()
    }

// MARK: - 手势关键
    private func preparebackView(){
        let pan = UIPanGestureRecognizer(target: self, action: "pan:")
        pan.delegate = self
        self.addGestureRecognizer(pan)
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool{
        
        if gestureRecognizer.isKindOfClass(UIPanGestureRecognizer.self){
            
            let pan = gestureRecognizer as!UIPanGestureRecognizer
            let point = pan.translationInView(backView)
            if abs(point.y) > abs(point.x){
                return false
            }
        }
        return true
    }
    
    
    func pan(pan:UIPanGestureRecognizer){
        let point = pan.translationInView(backView)
        maxMove(point)
        
        // 结束后的位置
        if pan.state == UIGestureRecognizerState.Ended {
            moveEnd()
        }
        // 清零防止累加
        pan.setTranslation(CGPointZero , inView: backView)
    }
    
   private func move(c:CGFloat , animation : Bool){
        self.leftConstraint?.constant += c
        self.rightConstraint?.constant += c
        if animation {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.setNeedsLayout()
                self.layoutIfNeeded()
            })
        }
    }
    
    
   private func maxMove(point : CGPoint){
        // 限制最大的滚动
        if point.x > 0 { // 左滑动
            if point.x + (leftConstraint?.constant)! >= 0 {
                move( -(leftConstraint?.constant)! , animation : false)
            }else {
                move(point.x , animation : false)
            }
            
        }else {
            if point.x + (rightConstraint?.constant)! <= 0 {
                move( -(rightConstraint?.constant)! , animation : false)
            }else {
                move(point.x , animation : false)
            }
        }
    }
    
    private func moveEnd(){
        if rightConstraint?.constant >= (leftView.wide * 0.5 + rightView.wide){
            openEditCell(leftConstraint)
        }else if rightConstraint?.constant >= rightView.wide {
            closeEditCell()
        }else if rightConstraint?.constant >= rightView.wide * 0.5 {
            closeEditCell()
        }else {
            openEditCell(rightConstraint)
        }
    }
    
    // 打开关闭cell 记录openCell 保证只有一条打开或关闭
    private func closeEditCell() {
        move(-(rightConstraint?.constant)! + rightView.wide , animation : true)
    }
    
    private func openEditCell(constraint:NSLayoutConstraint?){
        move(-(constraint?.constant)! , animation : true)
        if self != JYSwipeTableCell.openCell {
         JYSwipeTableCell.openCell?.closeEditCell()
        }
        JYSwipeTableCell.openCell = self
    }
    
    // MARK: 初始化懒加载控件
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backView)
        backView.addSubview(leftView)
        backView.addSubview(rightView)
        backView.addSubview(view)
        view.backgroundColor = UIColor.clearColor()
        let cons = backView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.all, v: contentView).leftSet(-leftView.wide).rightSet(rightView.wide))!
        leftConstraint = backView.ff_Constraint(cons, attribute: NSLayoutAttribute.Left)
        rightConstraint = backView.ff_Constraint(cons, attribute: NSLayoutAttribute.Right)
        
        leftView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unright, v: backView).width(leftView.wide))
        view.ff_edgesView(UIedgeView().top(backView , c: 0).bottom(backView, c: 0).left(leftView, c: 0).right(rightView, c: 0))
        rightView.ff_edgesView(UIedgeView().more(tlbr: ff_tlbr.unleft, v: backView).width(rightView.wide))
        
        // 注册手势
        preparebackView()
        // 设置选中样式
        selectionStyle = UITableViewCellSelectionStyle.None
        leftView.delegate = self
        rightView.delegate = self
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backView = UIView()
    private lazy var leftView : SwipeView = SwipeView(frame: CGRectZero, left: true)
    private lazy var rightView : SwipeView = SwipeView(frame: CGRectZero, left: false)
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
        backgroundColor = UIColor.clearColor()
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

    class func button(image: UIImage? = nil , backgroundImage : UIImage? = nil, backgroundColor : UIColor? = nil , text: String? = nil , textFont: UIFont? = nil, textcolor : UIColor? = nil , EdgeInsets : UIEdgeInsets? = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) ) -> SwipeButton {
        let but = SwipeButton(type: UIButtonType.Custom)
        but.setImage(image, forState: UIControlState.Normal)
        but.setBackgroundImage(backgroundImage, forState: UIControlState.Normal)
        but.backgroundColor = backgroundColor
        but.setTitle(text, forState: UIControlState.Normal)
        but.titleLabel?.font = textFont
        but.setTitleColor(textcolor, forState: UIControlState.Normal)
    
        but.adjustsImageWhenHighlighted = false
        but.contentEdgeInsets = EdgeInsets!
        but.sizeToFit()
        return but
    }
    
    func copyWithZone(zone: NSZone) -> AnyObject{

        let but = SwipeButton.button(imageForState(UIControlState.Normal), backgroundImage: backgroundImageForState(UIControlState.Normal), backgroundColor: backgroundColor, text: titleForState(UIControlState.Normal), textFont: titleLabel?.font, textcolor: titleColorForState(UIControlState.Normal),EdgeInsets : contentEdgeInsets)
        but.swipeButtonClick = self.swipeButtonClick
        return but
    }
}