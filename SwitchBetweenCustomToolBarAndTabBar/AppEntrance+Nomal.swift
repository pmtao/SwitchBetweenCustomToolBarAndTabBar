//
//  AppEntrance+Nomal.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-13.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

extension AppEntrance {
    // MARK: --AppFirstPageType.tab----------------👇
    
    func initialFromTab() {
        let tabCount = 3
        let tabBarStack = TabBarStack(with: tabCount)
        tabBarController = tabBarStack.tabBarController
        
        let tabBarItem1 = UITabBarItem(
            title: TabName.bookList.rawValue,
            image: Shop.getImage(.book),
            selectedImage: Shop.getImage(.book))
        let tabBarItem2 = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        let tabBarItem3 = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        
        let bookListVC = Shop.getVCFromStoryboard(
            .BookList, isInitialVC: true) as! MainTableViewController
        let favoriteVC = Shop.getVCFromStoryboard(
            .Favorites, isInitialVC: true)
        let recentVC = Shop.getVCFromStoryboard(
            .Recents, isInitialVC: true)
        
        for index in 0..<tabCount {
            let nv = tabBarStack.navigationControllers[index]
            switch index {
            case 0:
                nv.tabBarItem = tabBarItem1
                nv.pushViewController(bookListVC, animated: false)
            case 1:
                nv.tabBarItem = tabBarItem2
                nv.pushViewController(favoriteVC!, animated: false)
            case 2:
                nv.tabBarItem = tabBarItem3
                nv.pushViewController(recentVC!, animated: false)
            default:
                break
            }
        }
        
        // 依赖注入项
        bookListVC.toolBarView = initialToolBar()
        bookListVC.shouldShowNavigationItem = true
        bookListVC.tabBar = tabBarController?.tabBar
    }
    
    /// 初始化工具栏(此为 3 个 Tab 共用)
    func initialToolBar() -> ToolBarView {
        let toolBarView = ToolBarView.initView() // 初始化工具栏对象
        toolBarView.frame = getTabBarFrame() // 对工具栏进行布局
        // 添加至 TabBar 视图中
        tabBarController?.view.addSubview(toolBarView)
        toolBarView.isHidden = true // 默认隐藏
        return toolBarView
    }
    
    /// 获取 Tab 布局信息
    func getTabBarFrame() -> CGRect {
        var frame = CGRect()
        // 工具栏布局与 Tabbar 保持一致
        frame.origin = (tabBarController?.tabBar.frame.origin)!
        frame.size = (tabBarController?.tabBar.frame.size)!
        return frame
    }
    
    // MARK: --AppFirstPageType.nav----------------👇
    
    func initialFromNav() {
        navigationController = UINavigationController()
    }
    
    // MARK: --AppFirstPageType.login----------------👇
    
    func initialFromLogin() {
        viewController = UIViewController()
    }
    
    // MARK: --AppFirstPageType.introduce----------------👇
    
    func initialFromIntroduce() {
        viewController = UIViewController()
    }
}

class TabBarStack {
    var tabBarController: UITabBarController
    var navigationControllers: [UINavigationController] = []
    
    init(with tabCount: Int) {
        tabBarController = UITabBarController()
        for _ in 0..<tabCount {
            let navigationController = UINavigationController()
            navigationControllers.append(navigationController)
            tabBarController.viewControllers?.append(navigationController)
        }
        tabBarController.setViewControllers(navigationControllers, animated: false)
    }
}
