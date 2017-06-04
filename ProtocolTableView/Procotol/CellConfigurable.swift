//
//  CellConfigurable.swift
//  ProtocolTableView
//
//  Created by Smallfly on 2017/6/4.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

protocol CellConfigurable {
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    var selection: Selectable? { get }
    var height: CGFloat { get }
    
    func configureCell(_ cell: UITableViewCell)
}

protocol CellViewModel {
    associatedtype ViewModel
    var viewModel: ViewModel? { get }
    
    func configure(viewModel: ViewModel)
}

struct CellConfigurator<Cell: UITableViewCell>: CellConfigurable where Cell: CellViewModel {
    let viewModel: Cell.ViewModel
    let reuseIdentifier: String = NSStringFromClass(Cell.self)
    let cellClass: AnyClass = Cell.self
    let selection: Selectable?
    let height: CGFloat
    
    init(viewModel: Cell.ViewModel, height: CGFloat, selection: Selectable? = nil) {
        self.viewModel = viewModel
        self.height = height
        self.selection = selection
    }
    
    func configureCell(_ cell: UITableViewCell) {
        if let cell = cell as? Cell {
            cell.configure(viewModel: viewModel)
        }
        
    }
}
