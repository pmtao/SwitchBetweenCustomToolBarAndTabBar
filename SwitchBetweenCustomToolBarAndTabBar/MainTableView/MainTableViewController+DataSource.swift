//
//  MainTableViewController+DataSource.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

extension MainTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dynamicTableDataModel.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return dynamicTableDataModel[section].count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let model = dynamicTableDataModel[section][row]
        
        switch model {
        case let .bookInfo(bookInfo):
            let identifier = bookInfo.identifier.rawValue
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identifier, for: indexPath) as! BookInfoCell
            cell.configureCell(model: bookInfo)
            return cell
        case let .bookRating(bookRating):
            let identifier = bookRating.identifier.rawValue
            let cell = tableView.dequeueReusableCell(
                withIdentifier: identifier, for: indexPath) as! BookRatingCell
            cell.configureCell(model: bookRating)
            return cell
        }
    }
    
}
