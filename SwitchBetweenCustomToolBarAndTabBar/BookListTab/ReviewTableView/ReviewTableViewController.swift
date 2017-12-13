//
//  ReviewTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit
import SafariServices

class ReviewTableViewController: UITableViewController {
    // MARK: 1.--依赖注入属性定义----------------👇
    
    var bookRatingCellModel: BookRatingCellModel?
    
    // MARK: 2.--内部属性定义----------------👇
    
    /// ViewModel 模型
    var bookReviewViewModel: BookReviewViewModel! {
        didSet {
            if shouldReloadTable {
                tableView.reloadData()
            }
        }
    }
    
    /// 有数据更新时是否允许刷新表格
    var shouldReloadTable: Bool = false
    
    // MARK: 3.--@IBOutlet属性定义-----------👇
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    // MARK: 4.--视图生命周期----------------👇
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewModel() // 初始化视图模型
//        loadData() // 加载数据
        configureStaticCell(model: bookReviewViewModel.staticTableDataModel) // 配置 Cell 显示内容
        setupView() // 视图初始化
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // MARK: 5.--处理主逻辑-----------------👇
    
    /// 初始化视图模型
    func initialViewModel() {
        guard let bookRatingCellModel = self.bookRatingCellModel else {
            fatalError("缺少依赖的数据源")
        }
        bookReviewViewModel = BookReviewViewModel(bookRatingCellModel: bookRatingCellModel)
        
        bookReviewViewModel.loadData(
        bookRatingCellModel: bookRatingCellModel) { bookReviewViewModel in
            self.shouldReloadTable = true
            self.bookReviewViewModel = bookReviewViewModel
        }
    }
    
    /// 配置静态 Cell 显示内容
    func configureStaticCell<T: BookReviewHeadCellProtocol>(model: T) {
        bookNameLabel?.text = model.title
        rateLabel?.text = model.rate
    }
    
    /// 视图初始化相关设置
    func setupView() {
        // 注册 cell nib 文件
        for (nib, identifier) in bookReviewViewModel.cellNibs {
            let nib = UINib(nibName: nib.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier:  identifier.rawValue)
        }
    }
    
    // MARK: 6.--辅助函数-------------------👇
    
    // MARK: 7.--动作响应-------------------👇
    
    // MARK: 8.--事件响应-------------------👇
    
    // MARK: 9.--数据源方法------------------👇
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return bookReviewViewModel.sectionsDataModel.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return bookReviewViewModel.sectionsDataModel[section].cellCount
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let section = indexPath.section
        let row = indexPath.row
        
        if bookReviewViewModel.sectionsDataModel[section].cellType == .staticCell {
            let cell = super.tableView(tableView, cellForRowAt: indexPath)
            return cell
        } else {
            let model = bookReviewViewModel.dynamicTableDataModel[section][row]
            switch model {
            case let .bookReviewList(bookReviewList):
                let identifier = bookReviewList.identifier.rawValue
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: identifier, for: indexPath) as! BookReviewListTableViewCell
                cell.configureCell(model: bookReviewList)
                return cell
            case let .bookCommentList(bookCommentList):
                let identifier = bookCommentList.identifier.rawValue
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: identifier, for: indexPath) as! BookComentListTableViewCell
                cell.configureCell(model: bookCommentList)
                return cell
            }
        }
    }
    
    // MARK: 10.--视图代理方法----------------👇
    
    // 复用静态 cell 时要使用这个代理方法
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let section = indexPath.section
        if bookReviewViewModel.sectionsDataModel[section].cellType == .staticCell {
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
        if bookReviewViewModel.sectionsDataModel[section].cellType == .staticCell {
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
        return bookReviewViewModel.sectionsDataModel[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        let section = indexPath.section
        let row = indexPath.row
        if bookReviewViewModel.sectionsDataModel[section].cellType == .dynamicCell {
            let model = bookReviewViewModel.dynamicTableDataModel[section][row]
            
            switch model {
            case let .bookReviewList(bookReviewList):
                let SFSafariVC = SFSafariViewController(url: URL(string: bookReviewList.link)!)
                self.present(SFSafariVC, animated: true)
            case let .bookCommentList(bookCommentList):
                let SFSafariVC = SFSafariViewController(url: URL(string: bookCommentList.link)!)
                self.present(SFSafariVC, animated: true)
            }
        }
        
    }
}
