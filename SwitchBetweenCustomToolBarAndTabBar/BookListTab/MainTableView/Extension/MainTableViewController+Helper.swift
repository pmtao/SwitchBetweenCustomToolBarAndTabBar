//
//  MainTableViewController+Helper.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

extension MainTableViewController {
    // MARK: 1.--UI 设置-------------------👇
    /// 初始化表格背景视图
    func initialBackgroundView() {
        let tableFrame = tableView.frame
        var frame = CGRect()
        frame.size.height = 10
        frame.size.width = tableFrame.size.width
        frame.origin.x = tableFrame.origin.x
        frame.origin.y = tableFrame.origin.y / 2
        let label = UILabel(frame: frame)
        label.text = TableViewStatus.empty.rawValue
        label.textAlignment = .center
        statusLabel = label
        tableView.backgroundView = statusLabel
    }
    
    /// 设置表格背景视图
    ///
    /// - Parameter status: 表格状态
    func setBackgroundView(status: TableViewStatus) {
        switch status {
        case .loading:
            statusLabel?.text = status.rawValue
        default:
            statusLabel?.text = status.rawValue
            tableView.backgroundView = nil
        }
    }
    
    /// 初始化导航栏按钮
    func initialBarButton() {
        if shouldShowNavigationItem != nil && shouldShowNavigationItem! {
            let barButtonItem = UIBarButtonItem(
                title: "编辑",
                style: .done,
                target: self,
                action: #selector(self.rightBarButtonTapped(_:)))
            rightBarButtonItem = barButtonItem
        }
    }
    
    /// 切换表格的编辑与浏览状态
    func switchEditMode() {
        if tableView.isEditing {
            self.setEditing(false, animated: true) // 结束编辑模式
            rightBarButtonItem?.title = "编辑"
        } else {
            self.setEditing(true, animated: true) // 进入编辑模式
            rightBarButtonItem?.title = "取消"
        }
        let isEditing = tableView.isEditing
        toolBarView?.isHidden = shouldHideToolBar(isEditing: isEditing)
        tabBar?.isHidden = shouldHideTabBar(isEditing: isEditing)
    }
    
    func shouldHideToolBar(isEditing: Bool) -> Bool {
        if isEditing {
            return false
        } else {
            return true
        }
    }
    
    /// 确定是否需要隐藏 Tab 栏。
    func shouldHideTabBar(isEditing: Bool) -> Bool {
        if isEditing {
            return true
        } else {
            return false
        }
    }
    
    /// 对工具栏进行布局
    func setupToolBarFrame() {
        var frame = CGRect()
        // 工具栏布局与 Tabbar 保持一致
        frame.origin = (tabBar?.frame.origin)!
        frame.size = (tabBar?.frame.size)!
        toolBarView?.frame = frame
    }
    
    // MARK: 2.--事件注册与监听-------------------👇
    
    /// 注册需要监听的事件
    func addObserver() {
        // 监听设备旋转事件
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.orientationDidChange),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil)
        
        // 注册工具栏按钮点击
        toolBarView?.deleteButton.addTarget(
            self,
            action: #selector(self.toolBarDeleteButtonTapped(_:)),
            for: .touchUpInside)
    }
    
    // MARK: 3.--数据处理-------------------👇
    
    
    
    /// 初始化视图模型
    func initialViewModel() {
        bookListViewModel.loadData { bookListViewModel in
            self.shouldReloadTable = true
            self.bookListViewModel = bookListViewModel
        }
    }
    
    /// 删除选择的书籍
    func deleteSelectedBooks() {
        let indexPaths = selectedBooksIndexs.sorted()
        shouldReloadTable = false
        for indexPath in Array(indexPaths.reversed()) {
            bookListViewModel.dynamicTableDataModel[indexPath.section].remove(at: indexPath.row)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths.map { IndexPath(row: $0.row, section: $0.section) } ,
                             with: .fade)
        tableView.endUpdates()
    }
    
}
