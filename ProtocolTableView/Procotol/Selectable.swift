//
//  Selectable.swift
//  ProtocolTableView
//
//  Created by Smallfly on 2017/6/4.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

protocol Selectable {
    func didSelectedIndexPath(_ indexPath: IndexPath)
}


struct SelectAction: Selectable {
    private var selection: ((IndexPath) -> Void)
    
    init(selection: @escaping ((IndexPath) -> Void)) {
        self.selection = selection
    }
    
    func didSelectedIndexPath(_ indexPath: IndexPath) {
        selection(indexPath)
    }
}
