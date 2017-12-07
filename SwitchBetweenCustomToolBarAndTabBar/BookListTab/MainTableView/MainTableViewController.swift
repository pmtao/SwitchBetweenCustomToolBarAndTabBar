//
//  MainTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-25.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, TableViewDynamicCellDataModel {
    // MARK: 1.--依赖属性定义----------------👇
    /// 路由代理
    var delegate: BookListCoordinator?
    /// 数据源对象
    var dynamicTableDataModel: [[BookListCellModelType]] = [] {
        didSet {
            if shouldReloadTable {
                setBackgroundView(status: .loaded)
                tableView.reloadData()
            }
        }
    }
    /// section 数据对象
    var sectionsDataModel: [SectionModel] = []
    /// 是否显示导航栏按钮
    var shouldShowNavigationItem: Bool?
    
    // MARK: 2.--内部属性定义----------------👇
    
    /// 工具栏视图
//    var toolBarView: ToolBarView?
    /// 导航栏右侧按钮
    var rightBarButtonItem: UIBarButtonItem? {
        get {
            return navigationItem.rightBarButtonItem
        }
        
        set(newValue) {
            navigationItem.rightBarButtonItem = newValue
        }
    }
    
    /// 显示表格状态的标签，放在表格背景视图上。
    var statusLabel: UILabel?
    
    /// 有数据更新时是否允许刷新表格
    var shouldReloadTable: Bool = false
    /// 编辑状态下选中的书籍数组
    var selectedBooksIndexs: [IndexPath] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else {
            return []
        }
        var indexs: [IndexPath] = []
        for indexPath in indexPaths {
            indexs.append(indexPath)
        }
        return indexs
    }
    
    // MARK: 3.--@IBOutlet属性定义-----------👇
    
    
    // MARK: 3.--视图生命周期----------------👇
    override func viewDidLoad() {
        super.viewDidLoad()
        initialBackgroundView() // 初始化背景视图
//        initialToolBar() // 初始化工具栏
        initialBarButton() // 初始化导航栏按钮
        
        tableView.allowsMultipleSelectionDuringEditing = true // 允许编辑模式下多选
        loadData() // 加载数据
        setSectionDataModel() // 设置 section 数据模型
        addObserver() // 注册需要监听的对象
    }
    
    /// 设备旋转时重新布局
    @objc func orientationDidChange() {
        print("MainTableViewController updateLayoutWhenOrientationChanged")
        delegate?.orientationDidChange()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: 4.--动作响应-------------------👇
    @objc func rightBarButtonTapped(_ sender: Any?) {
        delegate?.mainTableVCRightBarButtonTapped(vc: self,
                                                  isEditing: tableView.isEditing)
    }
    
    // MARK: 5.--事件响应-------------------👇
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let selectedIndexPath = tableView.indexPath(for: cell)!
        
        let model = dynamicTableDataModel[selectedIndexPath.section][selectedIndexPath.row]
        switch model {
        case let .bookInfo(bookInfo):
            let detailVC = segue.destination as! DetailTableViewController
            detailVC.staticTableDataModel = TableViewViewModel.getBookDetail(model: bookInfo)
        case let .bookRating(bookRating):
            let reviewVC = segue.destination as! ReviewTableViewController
            reviewVC.staticTableDataModel =  TableViewViewModel.getBookReviewHead(model: bookRating)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String,
                                     sender: Any?)  -> Bool {
        // 编辑模式下禁止触发 segue
        if tableView.isEditing {
            return false
        } else {
            return true
        }
    }
    
}
