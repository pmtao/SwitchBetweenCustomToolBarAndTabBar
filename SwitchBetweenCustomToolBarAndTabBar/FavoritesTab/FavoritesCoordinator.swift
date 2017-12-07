//
//  FavoritesCoordinator.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-7.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class FavoritesCoordinator: NSObject, CoordinatorProtocol {
    var navigationController: UINavigationController
    var delegate: CoordinatorProtocol?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        guard let favoriteVC = Shop.getVCFromStoryboard(
            .Favorites, isInitialVC: true) else { return }
        navigationController.pushViewController(favoriteVC, animated: false)
    }
}
