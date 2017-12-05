//
//  BookRequest.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-1.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

/// 书籍查询的网络请求模型
struct BookRequest: Request {
    let userName: String // 用户名
    let status: String // 阅读状态：想读：wish 在读：reading 读过：read
    let start: Int // 起始编号
    let count: Int // 每次查询最大数量
    
    var path: String {
        return "/v2/book/user/\(userName)/collections?status=\(status)&start=\(start)&count=\(count)"
    }
    let method: HTTPMethod = .GET
    let parameter: [String: Any] = [:]
    
    
    func send(handler: @escaping (BookCollections?) -> Void) {
        URLSessionClient(host: HostType.doubanAPI.rawValue).send(self) { data in
            guard let data = data else { return }
            if let bookCollections = try? JSONDecoder().decode(BookCollections.self, from: data) {
                handler(bookCollections)
            } else {
                handler(nil)
                print("JSON parse failed")
            }
            
        }
    }
}
