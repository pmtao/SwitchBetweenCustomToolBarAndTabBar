//
//  MainTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-25.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, TableViewDynamicCellDataModel {
    // MARK: 1.--@IBOutlet属性定义-----------👇
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    // MARK: 2.--实例属性定义----------------👇
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
    
    /// 工具栏视图
    var toolBarView: ToolBarView?
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
    
    // MARK: 3.--视图生命周期----------------👇
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialBackgroundView() // 初始化背景视图
        loadData() // 加载数据
        setSectionDataModel() // 设置 section 数据模型
        tableView.allowsMultipleSelectionDuringEditing = true // 允许编辑模式下多选
        initialToolBar() // 初始化工具栏
        addObserver() // 注册需要监听的对象
    }
    
    /// 设备旋转时重新布局
    @objc func updateLayoutWhenOrientationChanged() {
        setupToolBarFrame() // 对工具栏进行布局
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: 4.--动作响应-------------------👇
    @IBAction func editButtonTapped(_ sender: Any) {
        switchEditMode()
    }
    
    /// 响应工具栏删除按钮点击
    @objc func deleteToolBarButtonTapped(_ sender: UIButton) {
        deleteSelectedBooks() // 删除选择的书籍
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
