//
//  DataModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-1.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

typealias DataModel = BookCollections

struct BookCollections: Codable {
    var total: Int = 0
    var collections: [MyBook] = []
}

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
