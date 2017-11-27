//
//  MainTableViewController.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-25.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    // MARK: 1.--@IBOutlet属性定义-----------👇
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    // MARK: 2.--实例属性定义----------------👇
    var bookList = [
        ["name": "读库","author": "张立宪", "press": "新星出版社"],
        ["name": "三体","author": "刘慈欣", "press": "重庆出版社"],
        ["name": "驱魔","author": "韩松", "press": "上海文艺出版社"],
        ["name": "叶曼拈花","author": "叶曼", "press": "中央编译出版社"],
        ["name": "南华录 : 晚明南方士人生活史","author": "赵柏田", "press": "北京大学出版社"],
        ["name": "青鸟故事集","author": "李敬泽", "press": "译林出版社"],
        ["name": "可爱的文化人","author": "俞晓群", "press": "岳麓书社"],
        ["name": "呼吸 : 音乐就在我们的身体里","author": "杨照", "press": "广西师范大学出版社"],
        ["name": "书生活","author": "马慧元", "press": "中华书局"],
        ["name": "叶弥六短篇","author": "叶弥", "press": "海豚出版社"],
        ["name": "美哉少年","author": "叶弥", "press": "江苏凤凰文艺出版社"],
        ["name": "新与旧","author": "沈从文", "press": "重庆大学出版社"],
        ["name": "银河帝国：基地","author": "艾萨克·阿西莫夫", "press": "江苏文艺出版社"],
        ["name": "世界上的另一个你","author": "朗·霍尔 丹佛·摩尔", "press": "湖南文艺出版社"],
        ["name": "奇岛","author": "林语堂", "press": "群言出版社"]
    ]
    
    /// 工具栏视图
    var toolBarView: ToolBarView?
    
    /// 编辑状态下选中的书籍数组
    var selectedBooksIndexs: [Int] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else {
            return []
        }
        var indexs: [Int] = []
        for indexPath in indexPaths {
            indexs.append(indexPath.row)
        }
        return indexs
    }
    
    // MARK: 3.--视图生命周期----------------👇
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    // MARK: 4.--处理主逻辑-----------------👇
    
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
    
    /// 初始化工具栏
    func initialToolBar() {
        toolBarView = ToolBarView.initView() // 初始化工具栏对象
        setupToolBarFrame() // 对工具栏进行布局
        // 添加至 TabBar 视图中
        self.tabBarController?.view.addSubview(toolBarView!)
        toolBarView?.isHidden = true // 默认隐藏
        registerToolBarButtonAction() // 注册按钮点击事件
    }
    
    /// 删除选择的书籍
    func deleteSelectedBooks() {
        let indexs = selectedBooksIndexs.sorted()
        for index in Array(indexs.reversed()) {
            bookList.remove(at: index)
        }
        tableView.beginUpdates()
        tableView.deleteRows(at: indexs.map { IndexPath(row: $0, section: 0) } ,
                             with: .fade)
        tableView.endUpdates()
        switchEditMode()
    }
    
    // MARK: 5.--辅助函数-------------------👇
    /// 注册工具栏按钮点击事件
    func registerToolBarButtonAction() {
        // 删除按钮
        toolBarView?.deleteButton.addTarget(
            self, action: #selector(self.deleteToolBarButtonTapped(_:)),
            for: .touchUpInside)
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
    
    /// 注册需要监听的事件
    func addObserver() {
        // 监听设备旋转事件
        NotificationCenter.default.addObserver(
        self,
        selector: #selector(self.updateLayoutWhenOrientationChanged),
        name: NSNotification.Name.UIDeviceOrientationDidChange,
        object: nil)
    }
    
    // MARK: 6.--动作响应-------------------👇
    @IBAction func editButtonTapped(_ sender: Any) {
        switchEditMode()
    }
    
    /// 响应工具栏删除按钮点击
    @objc func deleteToolBarButtonTapped(_ sender: UIButton) {
        deleteSelectedBooks() // 删除选择的书籍
    }
    
    // MARK: 7.--事件响应-------------------👇
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailTableViewController
        let cell = sender as! UITableViewCell
        let selectedIndexPath = tableView.indexPath(for: cell)!
        detailVC.bookDetail = bookList[selectedIndexPath.row]
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
    
    // MARK: 8.--数据源方法------------------👇
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell 
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "bookCell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = bookList[row]["name"]
        cell.detailTextLabel?.text = bookList[row]["author"]

        return cell
    }
    
    
    // MARK: 9.--视图代理方法----------------👇
    
    

}
