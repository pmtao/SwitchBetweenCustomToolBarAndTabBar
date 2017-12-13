//
//  AppEntrance.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-11.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class AppEntrance {
    var tabBarController: UITabBarController?
    var navigationController: UINavigationController?
    var viewController: UIViewController?
    
    let appEntranceType = AppEntranceType.nomal
    let appFirstPageType = AppFirstPageType.tab
    
    init() {
        switch appEntranceType {
        case .nomal:
            switch appFirstPageType {
            case .tab:
                initialFromTab()
            case .nav:
                initialFromNav()
            case .login:
                initialFromLogin()
            case .introduce:
                initialFromIntroduce()
            }
        case .url:
            openAppFromUrl()
        case .notify:
            break
        }
    }
    
    
}
