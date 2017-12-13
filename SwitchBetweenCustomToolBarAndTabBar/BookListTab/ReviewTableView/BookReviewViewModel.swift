//
//  BookReviewViewModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-7.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation
import RxSwift

struct BookReviewViewModel: TableViewMixedCellDataModel {
    // MARK: 1.--属性定义----------------👇
    
    /// 数据源对象
    var dynamicTableDataModel: [[BookReviewCellModelType]] = []
    var staticTableDataModel: BookReviewHeadCellModel
    var sectionsDataModel: [SectionModel] = []
    var cellNibs: [(CellNibType, CellIdentifierType)]
    let disposeBag = DisposeBag()
    
    // MARK: 2.--模型转换方法----------------👇
    
    init(dynamicTableDataModel: [[BookReviewCellModelType]],
         staticTableDataModel: BookReviewHeadCellModel,
         sectionsDataModel: [SectionModel],
         cellNibs: [(CellNibType, CellIdentifierType)]) {
        self.dynamicTableDataModel = dynamicTableDataModel
        self.staticTableDataModel = staticTableDataModel
        self.sectionsDataModel = sectionsDataModel
        self.cellNibs = cellNibs
    }
    
    /// 指定初始化方法
    init(bookRatingCellModel: BookRatingCellModel) {
        self.staticTableDataModel = BookReviewViewModel
            .transformToBookReviewHead(model: bookRatingCellModel)
        self.cellNibs = [(CellNibType.BookReviewListTableViewCell,
                         CellIdentifierType.bookReviewTitleCell),
                         (CellNibType.BookComentListTableViewCell,
                          CellIdentifierType.bookCommentTitleCell)]
    }
    
    mutating func loadData(bookRatingCellModel: BookRatingCellModel,
                         handler: @escaping (BookReviewViewModel) -> Void) {
        
        let getReviews = ReviewRepository.reviews(bookID: staticTableDataModel.id)
        let getComments = ReviewRepository.comments(bookID: staticTableDataModel.id)
        Observable.zip(getReviews, getComments) { bookReview, bookComment in
            var bookReviewViewModel = BookReviewViewModel(bookRatingCellModel: bookRatingCellModel)
            var dynamicTableDataModel: [[BookReviewCellModelType]] = [[], [], []]
            dynamicTableDataModel[1] = BookReviewViewModel.transformToBookReviewList(model: bookReview)
            dynamicTableDataModel[2] = BookReviewViewModel.transformToBookCommentList(model: bookComment)
            let sectionsDataModel =
                BookReviewViewModel.initialSectionDataModel(
                    dynamicTableDataModel: dynamicTableDataModel)
            
            bookReviewViewModel.dynamicTableDataModel = dynamicTableDataModel
            bookReviewViewModel.sectionsDataModel =  sectionsDataModel
            return bookReviewViewModel
        }
        .subscribe(onNext: { bookReviewViewModel in
            handler(bookReviewViewModel) })
        .disposed(by: disposeBag)
    }
    
    /// 初始化 section 数据模型
    static func initialSectionDataModel(
        dynamicTableDataModel: [[BookReviewCellModelType]]) -> [SectionModel]
    {
        let section1 = SectionModel(
            headerTitle: "书籍",
            footerTitle: nil,
            cellType: .staticCell,
            cellCount: 2)
        
        var section2CellCount = 0
        if dynamicTableDataModel.count > 0 {
            section2CellCount = dynamicTableDataModel[1].count
        }
        let section2 = SectionModel(
            headerTitle: "精选书评",
            footerTitle: nil,
            cellType: .dynamicCell,
            cellCount: section2CellCount)
        
        var section3CellCount = 0
        if dynamicTableDataModel.count > 0 {
            section3CellCount = dynamicTableDataModel[2].count
        }
        let section3 = SectionModel(
            headerTitle: "精选短评",
            footerTitle: nil,
            cellType: .dynamicCell,
            cellCount: section3CellCount)
        
        return [section1, section2, section3]
    }
    
    /// 获取 BookReviewListCellModel 数据模型
    ///
    /// - Parameter model: BookReview 数据模型
    /// - Returns: 书籍评论页需要的评论列表模型
    static func transformToBookReviewList(model: BookReview) -> [BookReviewCellModelType] {
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
        return cellModel
    }
    
    /// 获取 BookCommentListCellModel 数据模型
    ///
    /// - Parameter model: BookComment 数据模型
    /// - Returns: 书籍短评页需要的评论列表模型
    static func transformToBookCommentList(model: BookComment) -> [BookReviewCellModelType] {
        var cellModel: [BookReviewCellModelType] = []
        for comment in model.comments {
            var bookCommentListCellModel = BookCommentListCellModel()
            bookCommentListCellModel.summary = comment.summary
            bookCommentListCellModel.link = comment.alt
            // 转换为 enum 类型
            let model = BookReviewCellModelType.bookCommentList(bookCommentListCellModel)
            cellModel.append(model)
        }
        return cellModel
    }
    
    /// 获取 BookReviewHeadCellModel 数据模型
    ///
    /// - Parameter model: Book 数据模型
    /// - Returns: 书籍评论页需要的标题信息
    static func transformToBookReviewHead(model: BookRatingCellModel) -> BookReviewHeadCellModel {
        var cellModel = BookReviewHeadCellModel()
        cellModel.id = model.id
        cellModel.title = model.title
        cellModel.rate = model.average
        return cellModel
    }
}
