//
//  CellDataModelProtocol.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-5.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

// MARK: ----本文件统一存放与 Cell 对象的数据需求模型相关的协议----👇

/// 书籍列表中的书名类 Cell 数据协议
protocol BookInfoCellProtocol {
    var identifier: CellIdentifierType { get }
    var title: String { get }
    var authors: String { get }
    var publisher: String { get }
    var isbn13: String { get }
    var price: String { get }
    var pubdate: String { get }
    var summary: String { get }
}

/// 书籍列表中的评分类 Cell 数据协议
protocol BookRatingCellProtocol {
    var identifier: CellIdentifierType { get }
    var average: String { get }
    var numRaters: String { get }
    var id: String { get }
    var title: String { get }
}

/// 图书详情类 Cell 数据协议
protocol BookDetailCellProtocol {
    var title: String { get }
    var authors: String { get }
    var publisher: String { get }
}

/// 图书评论摘要列表数据协议
protocol BookReviewListCellProtocol {
    var identifier: CellIdentifierType { get }
    var title: String { get }
    var rate: String { get }
    var link: String { get }
}

/// 图书评论标题数据协议
protocol BookReviewHeadCellProtocol {
    var title: String { get }
    var rate: String { get }
}
