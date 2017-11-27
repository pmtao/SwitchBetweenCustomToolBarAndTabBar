//
//  DetailTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-25.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    // MARK: 1.--@IBOutlet属性定义-----------👇
    
    // MARK: 2.--实例属性定义----------------👇
    var bookDetail = ["name": "","author": "", "press": ""]
    
    // MARK: 3.--视图生命周期----------------👇
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = true // 允许编辑模式下多选
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: 4.--处理主逻辑-----------------👇
    
    // MARK: 5.--辅助函数-------------------👇
    
    // MARK: 6.--动作响应-------------------👇
    
    // MARK: 7.--事件响应-------------------👇
    
    
    // MARK: 8.--数据源方法------------------👇
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let row = indexPath.row
        switch row {
        case 0:
            cell.detailTextLabel?.text = bookDetail["name"]
        case 1:
            cell.detailTextLabel?.text = bookDetail["author"]
        case 2:
            cell.detailTextLabel?.text = bookDetail["press"]
        default:
            break
        }
        
        return cell
    }
    
    // MARK: 9.--视图代理方法----------------👇
    
}
