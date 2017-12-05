//
//  BookReviewRequest.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

struct BookReviewRequest: Request {
    let bookID: String // 书籍 ID
    let start: Int // 起始编号
    let count: Int // 每次查询最大数量
    
    var path: String {
        return "/v2/book/\(bookID)/reviews?start=\(start)&count=\(count)"
    }
    let method: HTTPMethod = .GET
    let parameter: [String: Any] = [:]
    
    func send(handler: @escaping (BookReview?) -> Void) {
        URLSessionClient(host: HostType.doubanAPI.rawValue).send(self) { data in
            guard let data = data else { return }
            if let bookReviews = try? JSONDecoder().decode(BookReview.self, from: data) {
                handler(bookReviews)
            } else {
                handler(nil)
                print("JSON parse failed")
            }
            
        }
    }
}
