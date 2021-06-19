//
//  ItemsDetailViewController.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 17/6/21.
//

import UIKit

enum ItemsDetaiRowType {
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
    
    private var colorInfo: ItemSizeAndColor?
    private var sizeInfo: ItemSizeAndColor?
    private var imageReource = [String]()
    var viewModel: ItemsDetailViewControllerToViewModel?
    private var rowTypes = [ItemsDetaiRowType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        addTableViewConstraints()
        viewModel?.getData()
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

extension ItemsDetailViewController: ItemsDetailViewModelToViewController {
    func updateView(for rowTypes: [ItemsDetaiRowType], withImageResource resource: [String], withColorInfo colorInfo: ItemSizeAndColor, withSizeInfo sizeInfo: ItemSizeAndColor) {
        DispatchQueue.main.async { [weak self] in
            self?.rowTypes = rowTypes
            self?.imageReource = resource
            self?.colorInfo = colorInfo
            self?.sizeInfo = sizeInfo
            self?.tableView.reloadData()
        }
    }
    
    func loadingIndicator(isLoading: Bool) {
        // loading indicator goes here
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
            
            cell.configure(imageResource: imageReource)
            cell.backgroundColor = .systemBackground
            
            return cell
        case .colorInfo, .sizeInfo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemSizeAndColorInfoTableViewCell.identifier, for: indexPath) as? ItemSizeAndColorInfoTableViewCell else { return UITableViewCell() }
            if rowTypes[indexPath.row] == .colorInfo {
                if let colorInfo = colorInfo {
                    cell.configure(withDataModel: colorInfo)
                }
            } else {
                if let sizeInfo = sizeInfo {
                    cell.configure(withDataModel: sizeInfo)
                }
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
