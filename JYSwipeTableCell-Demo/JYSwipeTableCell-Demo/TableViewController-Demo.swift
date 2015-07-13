//
//  TableViewController-Demo.swift
//  JYSwipeTableCell-Demo
//
//  Created by wei_jingyun on 15/7/13.
//  Copyright © 2015年 wei_jingyun. All rights reserved.
//

import UIKit
private   let JYTableCell = "JYSwipeTableCell"
class TableViewController_Demo: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.redColor()
        tableView.rowHeight = 100
        prepareTableViewCell()
    }
    
    func prepareTableViewCell(){
        tableView.registerClass(JYSwipeTableCell.self, forCellReuseIdentifier: JYTableCell)
        let but1 = SwipeButton.button(backgroundColor: UIColor.redColor(), text: "删除1", textFont: UIFont.systemFontOfSize(18), textcolor: UIColor.whiteColor())
        
        let but2 = SwipeButton.button(backgroundColor: UIColor.purpleColor(), text: "删除2", textFont: UIFont.systemFontOfSize(18), textcolor: UIColor.whiteColor())
        
        let but3 = SwipeButton.button(backgroundColor: UIColor.grayColor(), text: "删除3", textFont: UIFont.systemFontOfSize(18), textcolor: UIColor.whiteColor())
        
        but1.setButClick { (but, cell) -> () in
            print(but.titleForState(UIControlState.Normal))
        }
        
        but2.setButClick { (but, cell) -> () in
            print(but.titleForState(UIControlState.Normal))
        }
        
        but3.setButClick { (but, cell) -> () in
            print(but.titleForState(UIControlState.Normal))
        }
    
        
        JYSwipeTableCell.leftButtons = [but1 , but2 , but3]
    }
    
    func swipeButtonClick(){
        print("asdasd")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(JYTableCell, forIndexPath: indexPath) as! JYSwipeTableCell
        
        cell.view.backgroundColor = UIColor.purpleColor()

        return cell
    }
}
