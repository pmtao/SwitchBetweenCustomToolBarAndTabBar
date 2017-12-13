//
//  BookDetailViewModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-7.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

struct BookDetailViewModel: TableViewStaticCellDataModel {
    var staticTableDataModel: BookDetailCellModel
    var sectionsDataModel: [SectionModel]
    
    /// 此方法不公开
    private init(staticTableDataModel: BookDetailCellModel,
         sectionsDataModel: [SectionModel])
    {
        self.staticTableDataModel = staticTableDataModel
        self.sectionsDataModel = sectionsDataModel
    }
    
    /// 指定初始化方法
    init(with model: BookInfoCellModel) {
        let staticTableDataModel = BookDetailViewModel.transformToBookDetail(model: model)
        let sectionsDataModel = BookDetailViewModel.initialSectionDataModel()
        self.init(staticTableDataModel: staticTableDataModel, sectionsDataModel: sectionsDataModel)
    }
    
    /// 初始化 section 数据模型
    static func initialSectionDataModel() -> [SectionModel] {
        return [SectionModel(headerTitle: nil, footerTitle: nil, cellCount: 3)]
    }
    
    /// 将原始数据模型转换为 BookDetailCellModel 数据模型
    ///
    /// - Parameter model: BookInfoCellModel 数据模型
    /// - Returns: BookDetailCellModel 数据模型
    static func transformToBookDetail(model: BookInfoCellModel) -> BookDetailCellModel {
        var cellModel = BookDetailCellModel()
        cellModel.title = model.title
        cellModel.authors = model.authors
        cellModel.publisher = model.publisher
        return cellModel
    }
}
