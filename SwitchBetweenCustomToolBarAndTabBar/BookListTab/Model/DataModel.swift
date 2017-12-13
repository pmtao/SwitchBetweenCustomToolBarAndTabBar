//
//  DataModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-1.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

typealias DataModel = BookCollections


/// 书籍收藏信息结构体
struct BookCollections: Codable {
    var total: Int = 0
    var collections: [MyBook] = []
    
    struct MyBook: Codable {
        var status: String = ""
        var book: Book
    }
    
    struct Book: Codable {
        var title: String = ""
        var subtitle: String = ""
        var author: [String] = []
        var publisher: String = ""
        var isbn13: String?
        var price: String = ""
        var pubdate: String = ""
        var summary: String = ""
        var rating: BookRating
        var id: String = ""
    }
    
    struct BookRating: Codable {
        var average: String = ""
        var numRaters: Int = 0
    }
}

/// 书籍评论结构体
struct BookReview: Codable {
    var reviews: [Review] = []
    
    struct Review: Codable {
        var rating: Score
        var title: String = ""
        var alt: String = "" // 评论页链接
    }
    
    struct Score: Codable {
        var value: String = ""
    }
}

/// 书籍短评信息结构体
struct BookComment: Codable {
    var total: Int = 0
    var comments: [Comment]
    
    struct Comment: Codable {
        var summary: String
        var alt: String = "" // 页面链接
    }
}
