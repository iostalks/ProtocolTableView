//
//  TableViewCell.swift
//  ProtocolTableView
//
//  Created by bong on 2017/6/4.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, CellViewModel  {
    typealias ViewModel = TableViewCellViewModel
    var viewModel: ViewModel?
    
    fileprivate var switchControl: UISwitch? = nil
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: TableViewCellViewModel) {
        self.viewModel = viewModel
        imageView?.image = viewModel.image
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.detail
        
        if viewModel.action == nil {
            accessoryView = nil
            accessoryType = .disclosureIndicator
            selectionStyle = .default
        } else {
            switchControl = UISwitch()
            switchControl?.isOn = viewModel.isOn
            switchControl?.addTarget(self, action: #selector(didPressedSwitchControl(_:)), for: .valueChanged)

            accessoryView = switchControl
            selectionStyle = .none
        }
    }
    
    @objc
    fileprivate func didPressedSwitchControl(_ switchControl: UISwitch) {
        viewModel?.action?(switchControl.isOn)
    }
}
