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
