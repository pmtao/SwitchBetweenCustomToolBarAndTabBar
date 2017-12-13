//
//  MainTableViewController+ViewDelegate.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

extension MainTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String?
    {
        return bookListViewModel.sectionsDataModel[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        let model = bookListViewModel.dynamicTableDataModel[indexPath.section][indexPath.row]
        switch model {
        case let .bookInfo(bookInfo):
            let detailVC = Shop.getVCFromStoryboard(
                .BookList, with: .bookDetail) as! DetailTableViewController
            detailVC.bookDetailViewModel = BookDetailViewModel(with: bookInfo)
            // 编辑模式下不展示详情
            if !(tableView.isEditing) {
                show(detailVC, sender: self)
            }
        case let .bookRating(bookRating):
            let reviewVC = Shop.getVCFromStoryboard(
                .BookList, with: .bookReview) as! ReviewTableViewController
            reviewVC.bookRatingCellModel = bookRating
            // 编辑模式下不展示详情
            if !(tableView.isEditing) {
                show(reviewVC, sender: self)
            }
        }
        
    }
}
