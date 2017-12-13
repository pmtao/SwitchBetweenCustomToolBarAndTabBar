//
//  MainTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-25.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    // MARK: 1.--依赖注入属性定义----------------👇

    /// 是否显示导航栏按钮
    var shouldShowNavigationItem: Bool?
    var toolBarView: ToolBarView? // 工具栏视图
    var tabBar: UITabBar?
    
    // MARK: 2.--内部属性定义----------------👇
    /// ViewModel 模型
    var bookListViewModel: BookListViewModel = BookListViewModel() {
        didSet {
            if shouldReloadTable {
                setBackgroundView(status: .loaded)
                tableView.reloadData()
            }
        }
    }
    
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
    
    
    // MARK: 4.--视图生命周期----------------👇
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("MainTableViewController init coder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialBackgroundView() // 初始化背景视图
        initialBarButton() // 初始化导航栏按钮
        setBackgroundView(status: .loading)
        toolBarView?.isHidden = true // 默认隐藏工具栏
        tableView.allowsMultipleSelectionDuringEditing = true // 允许编辑模式下多选
        initialViewModel() // 初始化视图模型
        addObserver() // 注册需要监听的对象
        print("MainTableViewController viewDidLoad")
    }
    
    /// 设备旋转时重新布局
    @objc func orientationDidChange() {
        print("MainTableViewController updateLayoutWhenOrientationChanged")
        setupToolBarFrame() // 对工具栏进行布局
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: 5.--动作响应-------------------👇
    @objc func rightBarButtonTapped(_ sender: Any?) {
        switchEditMode()
    }
    
    @objc func toolBarDeleteButtonTapped(_ sender: Any?) {
        deleteSelectedBooks() // 删除选择的书籍
        switchEditMode()
    }
    
    // MARK: 6.--事件响应-------------------👇

    
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
