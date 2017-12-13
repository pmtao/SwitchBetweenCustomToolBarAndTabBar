//
//  BookListViewModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-2.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation
import RxSwift

struct BookListViewModel: TableViewDynamicCellDataModel {
    // MARK: 1.--属性定义----------------👇
    
    /// 数据源对象
    var dynamicTableDataModel: [[BookListCellModelType]] = []
    /// section 数据对象
    var sectionsDataModel: [SectionModel] = []
    let disposeBag = DisposeBag()
    
    // MARK: 2.--模型转换方法----------------👇
    
    func loadData(handler: @escaping (BookListViewModel) -> Void) {
        BookCollectionsRepository.collections()
            .subscribe(onNext: { bookCollections in
                let dynamicTableDataModel = BookListViewModel
                    .transformToTableDataModel(model: bookCollections)
                let sectionsDataModel = BookListViewModel.initialSectionDataModel()
                var viewModel = BookListViewModel()
                viewModel.dynamicTableDataModel = dynamicTableDataModel
                viewModel.sectionsDataModel = sectionsDataModel
                handler(viewModel)
            })
            .disposed(by: disposeBag)
    }
    
    /// 初始化 section 数据模型
    static func initialSectionDataModel() -> [SectionModel] {
        let section1 = SectionModel(
            headerTitle: "想看的书",
            footerTitle: nil,
            cellType: .dynamicCell)
        let section2 = SectionModel(
            headerTitle: "正在看的书",
            footerTitle: nil,
            cellType: .dynamicCell)
        let section3 = SectionModel(
            headerTitle: "已看完的书",
            footerTitle: nil,
            cellType: .dynamicCell)
        return [section1, section2, section3]
    }
    
    /// 构造表格统一的数据模型
    ///
    /// - Parameter model: 原始数据模型
    /// - Returns: 表格数据模型
    static func transformToTableDataModel(model: DataModel) -> [[BookListCellModelType]] {
        var bookWishToRead: [BookListCellModelType] = []
        var bookReading: [BookListCellModelType] = []
        var bookRead: [BookListCellModelType] = []
        for myBook in model.collections {
            guard let status = BookReadingStatus(rawValue: myBook.status) else {
                return []
            }
            let bookInfo = transformToBookInfo(model: myBook.book)
            let bookRating = transformToBookRating(model: myBook.book)
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
    static func transformToBookInfo(model: BookCollections.Book) -> BookListCellModelType {
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
    static func transformToBookRating(model: BookCollections.Book) -> BookListCellModelType {
        var cellModel = BookRatingCellModel()
        cellModel.average = "评分：" + model.rating.average
        cellModel.numRaters = "评价人数：" + String(model.rating.numRaters)
        cellModel.id = model.id
        cellModel.title = model.title
        return BookListCellModelType.bookRating(cellModel)
    }
    
    
}
