//
//  BookListCoordinator.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-7.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class BookListCoordinator: NSObject, CoordinatorProtocol {
    var navigationController: UINavigationController
    var delegate: AppCoordinator?
    var toolBarView: ToolBarView? // 工具栏视图
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        guard let bookListVC = Shop.getVCFromStoryboard(
            .BookList, isInitialVC: true) as? MainTableViewController else { return }
        bookListVC.delegate = self
        bookListVC.shouldShowNavigationItem = true
        navigationController.pushViewController(bookListVC, animated: false)
    }
    
    func mainTableVCRightBarButtonTapped(vc: MainTableViewController,
                                         isEditing: Bool) {
        vc.switchEditMode()
        // 此时还未进入编辑状态，点击后改变状态。
        let isEditing = !isEditing
        toolBarView?.isHidden = shouldHideToolBar(isEditing: isEditing)
        navigationController.tabBarController?.tabBar.isHidden = shouldHideTabBar(isEditing: isEditing)
    }
    
    func switchToolBarAndTabBar() {
        let shouldHideToolBar = !((toolBarView?.isHidden)!)
        toolBarView?.isHidden = shouldHideToolBar
        navigationController.tabBarController?.tabBar.isHidden = !shouldHideToolBar
    }
    
    func shouldHideToolBar(isEditing: Bool) -> Bool {
        if isEditing {
            return false
        } else {
            return true
        }
    }
    
    func shouldHideTabBar(isEditing: Bool) -> Bool {
        if isEditing {
            return true
        } else {
            return false
        }
    }
    
    func mainTableVCRowSelected(vc: MainTableViewController,
                                tableView: UITableView,
                                indexPath: IndexPath) {
        
    }
    
    func registerToolBarButtonAction() {
        toolBarView?.deleteButton.addTarget(
            self,
            action: #selector(self.toolBarDeleteButtonTapped(_:)),
            for: .touchUpInside)
    }
    
    @objc func toolBarDeleteButtonTapped(_ sender: Any?) {
        let bookListVC = navigationController.topViewController as! MainTableViewController
        bookListVC.deleteSelectedBooks() // 删除选择的书籍
        switchToolBarAndTabBar()
    }
    
    @objc func orientationDidChange() {
        delegate?.orientationDidChange()
    }
    
}
