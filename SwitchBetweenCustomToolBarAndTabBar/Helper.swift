//
//  Helper.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-07.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

struct Shop {
    
    static func storyboard(_ storyboardType: StoryboardType) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: nil)
        return storyboard
    }
    
    static func getVCFromStoryboard(_ storyboardType: StoryboardType,
                                       isInitialVC: Bool = false,
                                       with identifier: ViewControllorID = .none) -> UIViewController?
    {
        switch isInitialVC {
        case true:
            guard let vc = storyboard(storyboardType).instantiateInitialViewController() else {
                return nil
            }
            return vc
            
        case false:
            let vc = storyboard(storyboardType).instantiateViewController(
                withIdentifier: identifier.rawValue)
            return vc
        }
        
    }
    
    static func getImage(_ name: ImageName) -> UIImage? {
        return UIImage(named: name.rawValue)
    }
}


