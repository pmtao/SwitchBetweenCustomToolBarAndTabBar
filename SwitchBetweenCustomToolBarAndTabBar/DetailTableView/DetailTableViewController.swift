//
//  DetailTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-25.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController, TableViewStaticCellDataModel {
    // MARK: 1.--@IBOutlet属性定义-----------👇
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    
    // MARK: 2.--实例属性定义----------------👇
    var staticTableDataModel = BookDetailCellModel()
    var sectionsDataModel: [SectionModel] = []
    
    // MARK: 3.--视图生命周期----------------👇
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSectionDataModel() // 设置 section 数据模型
        configureCell(model: self.staticTableDataModel) // 配置 Cell 显示内容
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: 4.--处理主逻辑-----------------👇
    /// 设置 section 数据模型
    func setSectionDataModel() {
        sectionsDataModel = [SectionModel(headerTitle: nil,
                                          footerTitle: nil,
                                          cellCount: 3)]
    }
    
    /// 配置静态 Cell 显示内容
    func configureCell<T: BookDetailCellProtocol>(model: T) {
        nameLabel?.text = model.title
        authorsLabel?.text = model.authors
        publisherLabel?.text = model.publisher
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
    
    // MARK: 9.--视图代理方法----------------👇
    
}
