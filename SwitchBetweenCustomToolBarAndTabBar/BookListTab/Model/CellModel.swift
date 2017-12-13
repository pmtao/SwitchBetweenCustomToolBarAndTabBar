//
//  CellModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-2.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

/// 书籍列表的书籍名称类 cell 的数据结构体
struct BookInfoCellModel: BookInfoCellProtocol {
    var identifier = CellIdentifierType.bookInfoCell
    var title: String = ""
    var authors: String = ""
    var publisher: String = ""
    var isbn13: String = ""
    var price: String = ""
    var pubdate: String = ""
    var summary: String = ""
}

/// 书籍列表的书籍评分类 cell 的数据结构体
struct BookRatingCellModel: BookRatingCellProtocol {
    var identifier = CellIdentifierType.bookRatingCell
    var average: String = ""
    var numRaters: String = ""
    var id: String = ""
    var title: String = ""
}

/// 书籍详情类 cell 的数据结构体
struct BookDetailCellModel: BookDetailCellProtocol {
    var title: String = ""
    var authors: String = ""
    var publisher: String = ""
}

/// 书籍评论详情的摘要列表类 cell 的数据结构体
struct BookReviewListCellModel: BookReviewListCellProtocol {
    var identifier = CellIdentifierType.bookReviewTitleCell
    var title: String = ""
    var rate: String = ""
    var link: String = ""
}

/// 书籍评论详情的评论标题类 cell 的数据结构体
struct BookReviewHeadCellModel: BookReviewHeadCellProtocol {
    var id: String = ""
    var title: String = ""
    var rate: String = ""
}

struct BookCommentListCellModel: BookCommentListCellProtocol {
    var identifier = CellIdentifierType.bookCommentTitleCell
    var summary: String = ""
    var link: String = "" // 页面链接
}
