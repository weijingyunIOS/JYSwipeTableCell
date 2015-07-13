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
        let but1 = SwipeButton.button("删除1", textFont: 18, backgroundColor: UIColor.redColor())
        let but2 = SwipeButton.button("删除2", textFont: 18, backgroundColor: UIColor.redColor())
        let but3 = SwipeButton.button("删除3", textFont: 18, backgroundColor: UIColor.redColor())
        JYSwipeTableCell.leftButtons = [but1 , but2 , but3]
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
