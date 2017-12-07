//
//  TableViewViewModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-2.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

struct TableViewViewModel {
    
    /// 构造表格统一的数据模型
    ///
    /// - Parameter model: 原始数据模型
    /// - Returns: 表格数据模型
    static func getTableDataModel(model: DataModel) -> [[BookListCellModelType]] {
        var bookWishToRead: [BookListCellModelType] = []
        var bookReading: [BookListCellModelType] = []
        var bookRead: [BookListCellModelType] = []
        for myBook in model.collections {
            guard let status = BookReadingStatus(rawValue: myBook.status) else {
                return []
            }
            let bookInfo = getBookInfo(model: myBook.book)
            let bookRating = getBookRating(model: myBook.book)
            switch status {
            case .wish:
                bookWishToRead.append(bookInfo)
                bookWishToRead.append(bookRating)
            case .reading:
                bookReading.append(bookInfo)
                bookReading.append(bookRating)
            case .read:
                bookRead.append(bookInfo)
                bookRead.append(bookRating)
            case .all:
                break
            }
        }
        return [bookWishToRead, bookReading, bookRead]
    }
    
    /// 获取 BookInfoCellModel 数据模型
    ///
    /// - Parameter model: 原始数据子模型
    /// - Returns: 统一的 cell 数据模型
    static func getBookInfo(model: Book) -> BookListCellModelType {
        var cellModel = BookInfoCellModel()
        cellModel.title = model.title
        cellModel.authors = model.author.reduce("", { $0 == "" ? $1 : $0 + "、" + $1 })
        cellModel.publisher = model.publisher
        cellModel.isbn13 = model.isbn13 ?? ""
        cellModel.price = model.price
        cellModel.pubdate = model.pubdate
        cellModel.summary = model.summary
        return BookListCellModelType.bookInfo(cellModel)
    }
    
    /// 获取 BookRatingCellModel 数据模型
    ///
    /// - Parameter model: 原始数据子模型
    /// - Returns: 统一的 cell 数据模型
    static func getBookRating(model: Book) -> BookListCellModelType {
        var cellModel = BookRatingCellModel()
        cellModel.average = "评分：" + model.rating.average
        cellModel.numRaters = "评价人数：" + String(model.rating.numRaters)
        cellModel.id = model.id
        cellModel.title = model.title
        return BookListCellModelType.bookRating(cellModel)
    }
    
    /// 获取 BookDetailCellModel 数据模型
    ///
    /// - Parameter model: BookInfoCellModel 数据模型
    /// - Returns: BookDetailCellModel 数据模型
    static func getBookDetail(model: BookInfoCellModel) -> BookDetailCellModel {
        var cellModel = BookDetailCellModel()
        cellModel.title = model.title
        cellModel.authors = model.authors
        cellModel.publisher = model.publisher
        return cellModel
    }
    
    /// 获取 BookReviewListCellModel 数据模型
    ///
    /// - Parameter model: BookReview 数据模型
    /// - Returns: 书籍评论页需要的评论列表模型
    static func getBookReviewList(model: BookReview) -> [[BookReviewCellModelType]] {
        var cellModel: [BookReviewCellModelType] = []
        for review in model.reviews {
            var bookReviewListCellModel = BookReviewListCellModel()
            bookReviewListCellModel.title = review.title
            bookReviewListCellModel.rate = "评分：" + review.rating.value
            bookReviewListCellModel.link = review.alt
            // 转换为 enum 类型
            let model = BookReviewCellModelType.bookReviewList(bookReviewListCellModel)
            cellModel.append(model)
        }
        return [[], cellModel]
    }
    
    /// 获取 BookReviewHeadCellModel 数据模型
    ///
    /// - Parameter model: Book 数据模型
    /// - Returns: 书籍评论页需要的标题信息
    static func getBookReviewHead(model: BookRatingCellModel) -> BookReviewHeadCellModel {
        var cellModel = BookReviewHeadCellModel()
        cellModel.id = model.id
        cellModel.title = model.title
        cellModel.rate = model.average
        return cellModel
    }
}
