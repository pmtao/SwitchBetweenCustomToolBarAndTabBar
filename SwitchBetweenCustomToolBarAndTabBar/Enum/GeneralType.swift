//
//  GeneralType.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-13.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

/// Http 请求方法
public enum HTTPMethod: String {
    case GET
    case POST
}

public enum AppEntranceType {
    case nomal
    case url
    case notify
}

public enum AppFirstPageType {
    case tab
    case nav
    case login
    case introduce
}
