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
        prepareTableViewCell()
    }
    
    func prepareTableViewCell(){
        tableView.registerClass(JYSwipeTableCell.self, forCellReuseIdentifier: JYTableCell)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(JYTableCell, forIndexPath: indexPath) as! JYSwipeTableCell
    
        return cell
    }
}
