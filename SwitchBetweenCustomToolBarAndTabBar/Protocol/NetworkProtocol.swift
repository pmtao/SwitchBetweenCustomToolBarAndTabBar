//
//  NetworkProtocol.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-1.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

// MARK: ----本文件统一存放与网络请求相关的协议----👇

/// 网络请求发送协议
protocol Client {
    var host: String { get }
    func send<T: Request>(_ r: T, handler: @escaping (Data?) -> Void)
}

/// 网络请求内容协议
protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameter: [String: Any] { get }
}
