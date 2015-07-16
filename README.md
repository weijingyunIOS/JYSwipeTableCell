# 基于Swift2.0 的JYSwipeTableCell

注意： JYSwipeTableCell 是使用的自动布局，自动布局用的 FFAutoLayout-extension。功能简单
未传到pods。 MGSwipeTableCell-master框架写的功能细节处理更多纯OC，有兴趣的可以去搜搜。

![(演示动画)](http://images.cnblogs.com/cnblogs_com/weijingyun/712268/o_111.gif)


使用：
1.Cell 继承

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



2.but 添加

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




3. MARK: 滚动时收回cell 必须加上该句

    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        DemoCell.closeEditCell()
    }






