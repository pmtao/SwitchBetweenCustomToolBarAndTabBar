//
//  SectionModel.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-2.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation


/// TableView 中的 section 数据结构体
struct SectionModel: TableViewSection {
    var headerTitle: String?
    var footerTitle: String?
    var cellType: CellType
    var cellCount: Int
    
    init(headerTitle: String?,
         footerTitle: String?,
         cellType: CellType = .dynamicCell,
         cellCount: Int = 0)
    {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.cellType = cellType
        self.cellCount = cellCount
    }
}
