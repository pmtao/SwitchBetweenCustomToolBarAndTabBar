//
//  BookReviewListTableViewCell.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-5.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class BookReviewListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// 配置 Cell 显示内容
    func configureCell<T: BookReviewListCellProtocol>(model: T)
    {
        self.textLabel?.text = model.title
        self.detailTextLabel?.text = model.rate
    }
    
}
