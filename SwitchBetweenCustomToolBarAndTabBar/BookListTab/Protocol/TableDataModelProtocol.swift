//
//  TableDataModelProtocol.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-1.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

// MARK: ----本文件统一存放与 TableView 数据模型相关的协议----👇

/// TableView 动态类型数据模型协议。
/// 包含所有 Cell 数据的二维数组(第一层对应 section，第二层对应 section 下的 cell)，
/// 以及 Section 数据数组
protocol TableViewDynamicCellDataModel {
    associatedtype TableDataModelType: CellModelType
    associatedtype SectionItem: TableViewSection
    var dynamicTableDataModel: [[TableDataModelType]] { get set }
    var sectionsDataModel: [SectionItem] { get set }
}

/// TableView 静态类型数据模型协议。
/// 包含 Cell 结构体数据、 Section 数据数组
protocol TableViewStaticCellDataModel {
    associatedtype StaticCellDataModel
    associatedtype SectionItem: TableViewSection
    var staticTableDataModel: StaticCellDataModel { get set }
    var sectionsDataModel: [SectionItem] { get set }
}

/// TableView 动态、静态混合类型数据模型协议。
/// 包含动态 Cell 二维数组模型、静态 Cell 结构体数据、Section 数据数组、动态 Cell 的复用信息。
protocol TableViewMixedCellDataModel {
    associatedtype TableDataModelType: CellModelType
    associatedtype StaticCellDataModel
    associatedtype SectionItem: TableViewSection
    var dynamicTableDataModel: [[TableDataModelType]] { get set }
    var staticTableDataModel: StaticCellDataModel { get set }
    var sectionsDataModel: [SectionItem] { get set }
    var cellNibs: [(CellNibType, CellIdentifierType)] { get set }
}

/// TableView section 信息结构体模型协议，包含 section 标题信息等。
protocol TableViewSection {
    var headerTitle: String? { get }
    var footerTitle: String? { get }
}

/// Cell 统一数据模型协议
protocol CellModelType {
    // 此为包装协议，便于在其他协议中使用，可以为空。
}

