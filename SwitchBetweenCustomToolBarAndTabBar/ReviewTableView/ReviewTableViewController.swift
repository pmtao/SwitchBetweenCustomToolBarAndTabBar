//
//  ReviewTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit
import SafariServices

class ReviewTableViewController: UITableViewController, TableViewMixedCellDataModel {
    // MARK: 1.--@IBOutlet属性定义-----------👇
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    // MARK: 2.--实例属性定义----------------👇
    /// 数据源对象
    var dynamicTableDataModel: [[BookReviewCellModelType]] = [] {
        didSet {
            if shouldReloadTable {
                setSectionDataModel()
                tableView.reloadData()
            }
        }
    }
    var staticTableDataModel = BookReviewHeadCellModel()
    var sectionsDataModel: [SectionModel] = []
    var cellNibs: [(CellNibType, CellIdentifierType)] =
        [(.BookReviewListTableViewCell, .bookReviewTitleCell)]
    
    /// 有数据更新时是否允许刷新表格
    var shouldReloadTable: Bool = false
    
    // MARK: 3.--视图生命周期----------------👇
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData() // 加载数据
        setSectionDataModel() // 设置 section 数据模型
        configureStaticCell(model: staticTableDataModel) // 配置 Cell 显示内容
        setupView() // 视图初始化
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: 4.--处理主逻辑-----------------👇
    
    /// 加载初始数据
    func loadData() {
        let request = BookReviewRequest(bookID: staticTableDataModel.id,
                                        start: 0,
                                        count: 3)
        request.send { data in
            guard let dataModel = data else { return }
            let tableDataModel = TableViewViewModel.getBookReviewList(model: dataModel)
            self.shouldReloadTable = true
            self.dynamicTableDataModel = tableDataModel
        }
    }
    
    /// 设置 section 数据模型
    func setSectionDataModel() {
        let section1 = SectionModel(
            headerTitle: "书籍",
            footerTitle: nil,
            cellType: .staticCell,
            cellCount: 2)
        
        var section2CellCount = 0
        if dynamicTableDataModel.count > 0 {
            section2CellCount = dynamicTableDataModel[1].count
        }
        let section2 = SectionModel(
            headerTitle: "精选评论",
            footerTitle: nil,
            cellType: .dynamicCell,
            cellCount: section2CellCount)
        sectionsDataModel = [section1, section2]
    }
    
    /// 配置静态 Cell 显示内容
    func configureStaticCell<T: BookReviewHeadCellProtocol>(model: T) {
        bookNameLabel?.text = model.title
        rateLabel?.text = model.rate
    }
    
    /// 视图初始化相关设置
    func setupView() {
        // 注册 cell nib 文件
        for (nib, identifier) in cellNibs {
            let nib = UINib(nibName: nib.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier:  identifier.rawValue)
        }
    }
    
    // MARK: 5.--辅助函数-------------------👇
    
    // MARK: 6.--动作响应-------------------👇
    
    // MARK: 7.--事件响应-------------------👇
    
    // MARK: 8.--数据源方法------------------👇
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsDataModel.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return sectionsDataModel[section].cellCount
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let section = indexPath.section
        let row = indexPath.row
        
        if sectionsDataModel[section].cellType == .staticCell {
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            return cell
        } else {
            let model = dynamicTableDataModel[section][row]
            switch model {
            case let .bookReviewList(bookReviewList):
                let identifier = bookReviewList.identifier.rawValue
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: identifier, for: indexPath) as! BookReviewListTableViewCell
                cell.configureCell(model: bookReviewList)
                return cell
            }
        }
    }
    
    // MARK: 9.--视图代理方法----------------👇
    
    // 复用静态 cell 时要使用这个代理方法
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let section = indexPath.section
        if sectionsDataModel[section].cellType == .staticCell {
            return super.tableView(tableView, heightForRowAt: indexPath)
        } else {
            let prototypeCellIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, heightForRowAt: prototypeCellIndexPath)
        }
    }
    
    // 复用静态 cell 时要使用这个代理方法
    override func tableView(_ tableView: UITableView,
                            indentationLevelForRowAt indexPath: IndexPath) -> Int
    {
        let section = indexPath.section
        if sectionsDataModel[section].cellType == .staticCell {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        } else {
            // 将 storyBoard 中绘制的原型 cell 的 indentationLevel 赋予其他 cell
            let prototypeCellIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: prototypeCellIndexPath)
        }
    }
    
    // 设置分区标题
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?
    {
        return sectionsDataModel[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        let section = indexPath.section
        let row = indexPath.row
        if sectionsDataModel[section].cellType == .dynamicCell {
            let model = dynamicTableDataModel[section][row]
            
            switch model {
            case let .bookReviewList(bookReviewList):
                let SFSafariVC = SFSafariViewController(url: URL(string: bookReviewList.link)!)
                self.present(SFSafariVC, animated: true)
            }
        }
        
    }
}
