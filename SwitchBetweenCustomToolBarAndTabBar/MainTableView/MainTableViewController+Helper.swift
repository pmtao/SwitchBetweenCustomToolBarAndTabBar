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
    
    /// 初始化工具栏
    func initialToolBar() {
        toolBarView = ToolBarView.initView() // 初始化工具栏对象
        setupToolBarFrame() // 对工具栏进行布局
        // 添加至 TabBar 视图中
        self.tabBarController?.view.addSubview(toolBarView!)
        toolBarView?.isHidden = true // 默认隐藏
        registerToolBarButtonAction() // 注册按钮点击事件
    }
    
    /// 切换显示工具栏
    func switchToolBarAndTabbar() {
        if tableView.isEditing {
            self.tabBarController?.tabBar.isHidden = true // 隐藏 Tab 栏
            toolBarView?.isHidden = false // 显示工具栏
        } else {
            self.tabBarController?.tabBar.isHidden = false // 显示 Tab 栏
            toolBarView?.isHidden = true // 隐藏工具栏
        }
    }
    
    /// 对工具栏进行布局
    func setupToolBarFrame() {
        var frame = CGRect()
        // 工具栏布局与 Tabbar 保持一致
        frame.origin = (self.tabBarController?.tabBar.frame.origin)!
        frame.size = (self.tabBarController?.tabBar.frame.size)!
        toolBarView?.frame = frame
    }
    
    /// 切换表格的编辑与浏览状态
    func switchEditMode() {
        if tableView.isEditing {
            self.setEditing(false, animated: true) // 结束编辑模式
            editButton.title = "编辑"
        } else {
            self.setEditing(true, animated: true) // 进入编辑模式
            editButton.title = "取消"
        }
        switchToolBarAndTabbar() // 切换显示工具栏
    }
    
    // MARK: 2.--事件注册与监听-------------------👇
    
    /// 注册需要监听的事件
    func addObserver() {
        // 监听设备旋转事件
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateLayoutWhenOrientationChanged),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil)
    }
    
    /// 注册工具栏按钮点击事件
    func registerToolBarButtonAction() {
        // 删除按钮
        toolBarView?.deleteButton.addTarget(
            self, action: #selector(self.deleteToolBarButtonTapped(_:)),
            for: .touchUpInside)
    }
    
    // MARK: 3.--数据处理-------------------👇
    
    /// 设置 section 数据模型
    func setSectionDataModel() {
        let section1 = SectionModel(
            headerTitle: "想看的书",
            footerTitle: nil,
            cellType: .dynamicCell)
        let section2 = SectionModel(
            headerTitle: "正在看的书",
            footerTitle: nil,
            cellType: .dynamicCell)
        let section3 = SectionModel(
            headerTitle: "已看完的书",
            footerTitle: nil,
            cellType: .dynamicCell)
        sectionsDataModel.append(section1)
        sectionsDataModel.append(section2)
        sectionsDataModel.append(section3)
    }
    
    /// 加载初始数据
    func loadData() {
        setBackgroundView(status: .loading)
        let request = BookRequest(userName: "pmtao", status: "", start: 0, count: 40)
        request.send { data in
            guard let dataModel = data else { return }
            let tableDataModel = TableViewViewModel.getTableDataModel(model: dataModel)
            self.shouldReloadTable = true
            self.dynamicTableDataModel = tableDataModel
        }
    }
    
    /// 删除选择的书籍
    func deleteSelectedBooks() {
        let indexPaths = selectedBooksIndexs.sorted()
        shouldReloadTable = false
        for indexPath in Array(indexPaths.reversed()) {
            dynamicTableDataModel[indexPath.section].remove(at: indexPath.row)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPaths.map { IndexPath(row: $0.row, section: $0.section) } ,
                             with: .fade)
        tableView.endUpdates()
        switchEditMode()
    }
    
}
