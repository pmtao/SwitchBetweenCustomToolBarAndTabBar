//
//  BookRatingCell.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class BookRatingCell: UITableViewCell {
    // MARK: 1.--@IBOutlet属性定义-------------------👇
    
    // MARK: 2.--初始化方法-------------------👇
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// 配置 Cell 显示内容
    ///
    /// - Parameter model: 可适配 BookRatingCellProtocol 协议的模型
    func configureCell<T: BookRatingCellProtocol>(model: T) {
        self.textLabel?.text = model.average
        self.detailTextLabel?.text = model.numRaters
    }
}
