//
//  ItemsDetailViewController.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 17/6/21.
//

import UIKit

fileprivate enum ItemsDetaiRowType {
    case caraouselImage
    case colorInfo
    case sizeInfo
    case shippingInfo
}

class ItemsDetailViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ItemDetailCaraouselTableViewCell.self, forCellReuseIdentifier: ItemDetailCaraouselTableViewCell.identifier)
        table.register(ItemSizeAndColorInfoTableViewCell.self, forCellReuseIdentifier: ItemSizeAndColorInfoTableViewCell.identifier)
        table.register(ItemShippingInfoTableViewCell.self, forCellReuseIdentifier: ItemShippingInfoTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.tableFooterView = UIView()
        
        return table
    }()
    
    private let rowTypes: [ItemsDetaiRowType] = [.caraouselImage, .colorInfo, .sizeInfo, .shippingInfo]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        addTableViewConstraints()
    }
    
    private func addTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension ItemsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rowTypes[indexPath.row] {
        case .caraouselImage:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemDetailCaraouselTableViewCell.identifier, for: indexPath) as? ItemDetailCaraouselTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(imageResource: ["item1","item2","item3"])
            cell.backgroundColor = .systemBackground
            
            return cell
        case .colorInfo, .sizeInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemSizeAndColorInfoTableViewCell.identifier, for: indexPath) as? ItemSizeAndColorInfoTableViewCell else { return UITableViewCell() }
            if rowTypes[indexPath.row] == .colorInfo {
                cell.configure(withDataModel: ItemSizeAndColor(availableColorCount: nil, availableSizeCount: nil, title: "Color", availableResourceImageNames: ["sandel1","sandel2","sandel3","sandel4","sandel5"], avaiLabelItemText: nil))
            } else {
                cell.configure(withDataModel: ItemSizeAndColor(availableColorCount: nil, availableSizeCount: nil, title: "Size", availableResourceImageNames: nil, avaiLabelItemText: ["S","M","XL","XXL"]))
            }
            
            cell.backgroundColor = .systemBackground
            
            return cell
        case .shippingInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemShippingInfoTableViewCell.identifier, for: indexPath) as? ItemShippingInfoTableViewCell else { return UITableViewCell() }
            
            cell.configure()
            
            cell.backgroundColor = .systemBackground
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch rowTypes[indexPath.row] {
        case .caraouselImage:
            return 250
        case .colorInfo, .sizeInfo:
            return 120
        default:
            return 100
        }
    }
}
