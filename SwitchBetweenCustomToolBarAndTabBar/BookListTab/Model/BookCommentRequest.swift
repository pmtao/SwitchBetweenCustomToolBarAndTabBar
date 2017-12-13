//
//  BookCommentRequest.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-12.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

struct BookCommentRequest: Request {
    let bookID: String // 书籍 ID
    let start: Int // 起始编号
    let count: Int // 每次查询最大数量
    
    var path: String {
        return "/v2/book/\(bookID)/comments?start=\(start)&count=\(count)"
    }
    let method: HTTPMethod = .GET
    let parameter: [String: Any] = [:]
    
    func send(handler: @escaping (BookComment?) -> Void) {
        URLSessionClient(host: HostType.doubanAPI.rawValue).send(self) { data in
            guard let data = data else { return }
            if let bookComments = try? JSONDecoder().decode(BookComment.self, from: data) {
                handler(bookComments)
            } else {
                handler(nil)
                print("JSON parse failed")
            }
            
        }
    }
}
