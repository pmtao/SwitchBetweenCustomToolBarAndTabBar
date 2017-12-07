//
//  ResourceType.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-7.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

public enum StoryboardType: String {
    case Main
    case BookList
    case Favorites
    case Recents
    
}

public enum ViewControllorID: String {
    case none = ""
    case bookDetail
    case bookReview
}

public enum TabName: String {
    case bookList = "书籍列表"
}

public enum ImageName: String {
    case book
}
