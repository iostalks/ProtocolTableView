//
//  TableViewCellViewModel.swift
//  ProtocolTableView
//
//  Created by bong on 2017/6/4.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

struct TableViewCellViewModel {
    let title: String
    let detail: String?
    let image: UIImage
    let isOn: Bool
    let action: ((Bool) -> Void)?
    
    init(title: String, detail: String? = nil, image: UIImage, isOn: Bool, action: ((Bool) -> Void)? = nil) {
        self.title = title
        self.detail = detail
        self.image = image
        self.isOn = isOn
        self.action = action
    }
}
