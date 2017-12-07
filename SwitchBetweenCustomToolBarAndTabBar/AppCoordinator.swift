//
//  AppCoordinator.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-7.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, UITabBarControllerDelegate, CoordinatorProtocol {
    var tabBarController: UITabBarController
    var childCoordinators: [CoordinatorProtocol] = []
    var toolBarView: ToolBarView?
    
    init(with tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        super.init()
    }
    
    func start() {
        initialTab() // 初始化各 Tab 中的控制器
    }
    
    func initialTab() {
        let bookListCoordinator = BookListCoordinator(with: UINavigationController())
        bookListCoordinator.delegate = self
        bookListCoordinator.start()
        
        let favoritesCoordinator = FavoritesCoordinator(with: UINavigationController())
        favoritesCoordinator.delegate = self
        favoritesCoordinator.start()
        
        let recentsCoordinator = RecentsCoordinator(with: UINavigationController())
        recentsCoordinator.delegate = self
        recentsCoordinator.start()
        
        let tabBarItem1 = UITabBarItem(
            title: TabName.bookList.rawValue,
            image: Shop.getImage(.book),
            selectedImage: Shop.getImage(.book))
        let tabBarItem2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let tabBarItem3 = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        
        bookListCoordinator.navigationController.tabBarItem = tabBarItem1
        favoritesCoordinator.navigationController.tabBarItem = tabBarItem2
        recentsCoordinator.navigationController.tabBarItem = tabBarItem3
        
        childCoordinators.append(bookListCoordinator)
        childCoordinators.append(favoritesCoordinator)
        childCoordinators.append(recentsCoordinator)
        
        // 初始化工具栏(此为 3 个 Tab 共用)
        bookListCoordinator.toolBarView = initialToolBar(childCoordinators: childCoordinators)
        bookListCoordinator.registerToolBarButtonAction() // 注册按钮点击事件
        
        tabBarController.delegate = self
        tabBarController.setViewControllers(
            [bookListCoordinator.navigationController,
             favoritesCoordinator.navigationController,
             recentsCoordinator.navigationController],
            animated: false)
    }
    
    /// 初始化工具栏
    func initialToolBar(childCoordinators: [CoordinatorProtocol]) -> ToolBarView? {
        toolBarView = ToolBarView.initView() // 初始化工具栏对象
        setupToolBarFrame() // 对工具栏进行布局
        // 添加至 TabBar 视图中
        tabBarController.view.addSubview(toolBarView!)
        toolBarView?.isHidden = true // 默认隐藏
        return toolBarView
    }
    
    /// 对工具栏进行布局
    func setupToolBarFrame() {
        var frame = CGRect()
        // 工具栏布局与 Tabbar 保持一致
        frame.origin = tabBarController.tabBar.frame.origin
        frame.size = tabBarController.tabBar.frame.size
        toolBarView?.frame = frame
    }
    
    /// 切换 Tab 时，需要在当前页注册 ToolBar 点击事件，并反注册其他页的 ToolBar 点击事件。
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0:
            if let bookListCoordinator = childCoordinators.first as? BookListCoordinator {
                bookListCoordinator.registerToolBarButtonAction()
            }
        case 1:
            return
        case 2:
            return
        default:
            break
        }
    }
    
    /// 设备旋转时重新布局
    @objc func orientationDidChange() {
        print("updateLayoutWhenOrientationChanged")
        setupToolBarFrame() // 对工具栏进行布局
    }
}
