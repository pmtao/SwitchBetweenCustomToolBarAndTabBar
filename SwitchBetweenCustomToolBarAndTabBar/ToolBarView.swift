//
//  ToolBarView.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-11-26.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import UIKit

class ToolBarView: UIView {

    @IBOutlet weak var deleteButton: UIButton!
    
    class func initView() -> ToolBarView {
        let myClassNib = UINib(nibName: "ToolBarView", bundle: nil)
        let toolBarView = myClassNib.instantiate(
            withOwner: nil,
            options: nil)[0] as! ToolBarView
        return toolBarView
    }

}
