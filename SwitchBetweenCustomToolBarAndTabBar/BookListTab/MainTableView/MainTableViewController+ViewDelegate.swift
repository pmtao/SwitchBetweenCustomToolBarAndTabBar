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
        return sectionsDataModel[section].headerTitle
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.mainTableVCRowSelected(vc: self,
                                         tableView: tableView,
                                         indexPath: indexPath)
    }
}
