//
//  Enums.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-2.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

/// 表格状态
public enum TableViewStatus: String {
    case loading = "正在加载数据，请稍后😊"
    case error = "数据出现了点问题，没办法😔"
    case empty = "我饿了，等我先吃点东西吧🍕"
    case loaded = "热乎乎的数据准备好了✌️"
}

/// 书籍阅读状态
public enum BookReadingStatus: String {
    case wish
    case reading
    case read
    case all = ""
}

/// 列举表格中包含的所有动态 cell 标识符
public enum CellIdentifierType: String {
    case bookInfoCell
    case bookRatingCell
    case bookReviewTitleCell
    case bookCommentTitleCell
}

/// Cell nib 文件类型
public enum CellNibType: String {
    case BookReviewListTableViewCell
    case BookComentListTableViewCell
}

/// cell 类型
///
/// - staticCell: 静态
/// - dynamicCell: 动态
public enum CellType: String {
    case staticCell
    case dynamicCell
}


/// 书籍列表 Cell 使用的数据模型类型
///
/// - bookInfo: 图书基本信息
/// - bookRating: 图书评分信息
enum BookListCellModelType: CellModelType {
    case bookInfo(BookInfoCellModel)
    case bookRating(BookRatingCellModel)
}

/// 书籍评论列表页的评分项 Cell 使用的数据模型类型
enum BookReviewCellModelType: CellModelType {
    case bookReviewList(BookReviewListCellModel) // 书评
    case bookCommentList(BookCommentListCellModel) // 短评
}
