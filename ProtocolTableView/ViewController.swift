//
//  ViewController.swift
//  ProtocolTableView
//
//  Created by Smallfly on 2017/6/4.
//  Copyright © 2017年 Smallfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModels = [TableViewCellViewModel]()
    fileprivate var selectionActions = [SelectAction?]()
    fileprivate var dataArray = [CellConfigurable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCellModelTitle("飞行模式", image: UIImage(named: "ku")!) { (isOn) in
            
        }
        addCellModelTitle("Wi-Fi", detail:  "CMCC", image: UIImage(named: "kaixin")!, selection: SelectAction(selection: { (indexPath) in
            print("did Selected IndexPath\(indexPath.row)")
        }))
        addCellModelTitle("蓝牙", detail: "打开", image:  UIImage(named: "mengb")!, selection: SelectAction(selection: { (indexPath) in
            print("did Selected IndexPath\(indexPath.row)")
        }))
        addCellModelTitle("蜂窝流量", image:  UIImage(named: "xiao")!, selection: SelectAction(selection: { (indexPath) in
            print("did Selected IndexPath\(indexPath.row)")
        }))
        addCellModelTitle("个人热点", image:  UIImage(named: "tuse")!, selection: SelectAction(selection: { (indexPath) in
            print("did Selected IndexPath\(indexPath.row)")
        }))
        addCellModelTitle("VPN", detail:  nil, image: UIImage(named: "qinwen")!) { (isOn) in
        }
        
        addDataSource()
    }
}

extension ViewController {
    fileprivate func addCellModelTitle(_ title: String, detail: String? = nil, image: UIImage,
                                       selection: SelectAction? = nil,
                                       switchAction: ((Bool) -> Void)? = nil) {
        let viewModel = TableViewCellViewModel(title: title, detail: detail, image: image, isOn: false, action: switchAction)
        viewModels.append(viewModel)
        selectionActions.append(selection)
    }
    
    fileprivate func addDataSource() {
        for (index, viewModel) in viewModels.enumerated() {
            let configurator = CellConfigurator<TableViewCell>(viewModel: viewModel,
                                                               height: 44,
                                                               selection: selectionActions[index])
            dataArray.append(configurator)
        }
        
        if dataArray.count > 0, let configurator = dataArray.first {
            tableView.register(configurator.cellClass, forCellReuseIdentifier: configurator.reuseIdentifier)
        }
    }
    
    func updateViewModel(_ viewModel: TableViewCellViewModel, indexPath: IndexPath) {
        
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurator = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: configurator.reuseIdentifier, for: indexPath)
        configurator.configureCell(cell)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let configurator = dataArray[indexPath.row]
        return configurator.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let configurator = dataArray[indexPath.row]
        configurator.selection?.didSelectedIndexPath(indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

