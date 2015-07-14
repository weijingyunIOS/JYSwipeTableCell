//
//  TableViewController-Demo.swift
//  JYSwipeTableCell-Demo
//
//  Created by wei_jingyun on 15/7/13.
//  Copyright © 2015年 wei_jingyun. All rights reserved.
//

import UIKit
private  let JYDemoCell = "JYDemoCell"
class TableViewController_Demo: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        prepareTableViewCell()
    }
    
    // MARK: cell 以及but 回调设置
    func prepareTableViewCell(){
        // 注册DemoCell
        tableView.registerClass(DemoCell.self, forCellReuseIdentifier: JYDemoCell)
        
        // 左边的图片 but 
        let edge = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let imageBut1 = SwipeButton.button(UIImage(named: "check"),backgroundColor: UIColor.greenColor(),EdgeInsets:edge)
        let imageBut2 = SwipeButton.button(UIImage(named: "fav"),backgroundColor: UIColor(red: 0, green: 0x99/255.0, blue: 0xcc/255.0, alpha: 1.0),EdgeInsets:edge)
        let imageBut3 = SwipeButton.button(UIImage(named: "menu"),backgroundColor: UIColor(red: 0.59, green: 0.29, blue: 0.08, alpha: 1.0),EdgeInsets:edge)
        
        imageBut1.setButClick { (but, cell) -> () in
            print("check")
        }
        
        imageBut2.setButClick { (but, cell) -> () in
            print("fav")
        }
        
        imageBut3.setButClick { (but, cell) -> () in
            print("menu")
        }
        
        DemoCell.leftButtons = [imageBut1 , imageBut2 , imageBut3]
        
        
        // 右边的文字 but
        let textBut1 = SwipeButton.button(backgroundColor: UIColor.redColor(), text: "删除", textFont: UIFont.systemFontOfSize(22), textcolor: UIColor.whiteColor())
        let textBut2 = SwipeButton.button(backgroundColor: UIColor.orangeColor(), text: "移动", textFont: UIFont.systemFontOfSize(22), textcolor: UIColor.whiteColor())
    
        textBut1.setButClick { (but, cell) -> () in
            print(but.titleForState(UIControlState.Normal))
        }
        
        textBut2.setButClick { (but, cell) -> () in
            print(but.titleForState(UIControlState.Normal))
        }
        
        DemoCell.rightButtons = [textBut2 , textBut1]
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(JYDemoCell, forIndexPath: indexPath) as! DemoCell
        cell.label.text = "\(indexPath.row) 行 左边图片按钮 右边文字按钮"
        return cell
    }
    
    // MARK: 滚动时收回cell 必须加上该句
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        DemoCell.closeEditCell()
    }
}
