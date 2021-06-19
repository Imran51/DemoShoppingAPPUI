//
//  ItemViewController.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 14/6/21.
//

import UIKit

enum ProductRowType {
    case item
    case size
    case other
    case shipping
}

class ItemViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(ItemInfoTableViewCell.self, forCellReuseIdentifier: ItemInfoTableViewCell.identifier)
        table.register(ItemSizeAndColorInfoTableViewCell.self, forCellReuseIdentifier: ItemSizeAndColorInfoTableViewCell.identifier)
        table.register(ItemOtherInfoTableViewCell.self, forCellReuseIdentifier: ItemOtherInfoTableViewCell.identifier)
        table.register(ItemShippingInfoTableViewCell.self, forCellReuseIdentifier: ItemShippingInfoTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
        
        
        return table
    }()
    
    private let bottomStackView = ViewUtils.customStackview(withSpacing: 0, withAxis: .horizontal)
    
    private let leftBottomAddToCartButton: BadgeButton = {
        let button = BadgeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(named: "addTocart"), for: .normal)
        button.backgroundColor = UIColor(hexString: "#E9FFF5")
        button.badgeValue = "1"
        
        return button
    }()
    
    private let bottomMiddleAddToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ADD TO CART", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    private let bottomRightBuyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BUY NOW", for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.textColor = .white
        
        return button
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    deinit {
        print("memory deallocating succesfully called...")
    }
    
    private var rowTypes = [ProductRowType]()
    var viewModel: ItemViewControllerToViewModel?
    private var itemInfo: ItemInfo?
    private var itemSizeAndColrInfo: ItemSizeAndColor?
    private var othersInfos = [OtherInfoCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(leftBottomAddToCartButton)
        bottomStackView.addArrangedSubview(bottomMiddleAddToCartButton)
        bottomStackView.addArrangedSubview(bottomRightBuyButton)
        bottomStackView.addArrangedSubview(emptyView)
        
        
        addTableViewConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel?.getData()
    }
    
    private func addTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50),
            bottomMiddleAddToCartButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2-35),
            bottomRightBuyButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2-35)
        ])
    }
    
    private func navigateToItemDetailsPage() {
        guard let nav = self.navigationController else {
            return
        }
        viewModel?.router?.showViewController(from: nav)
    }
}


extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rowTypes[indexPath.row] {
        case .item:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemInfoTableViewCell.identifier, for: indexPath) as? ItemInfoTableViewCell else {
                return UITableViewCell()
            }
            if let data = itemInfo {
                cell.configure(with: data)
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .systemBackground
            
            return cell
        case .size:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemSizeAndColorInfoTableViewCell.identifier, for: indexPath) as? ItemSizeAndColorInfoTableViewCell else { return UITableViewCell() }
            if let sizeAndColorInfo = itemSizeAndColrInfo {
                cell.configure(withDataModel: sizeAndColorInfo)
            }
            
            cell.delegate = self
            cell.selectionStyle = .none
            cell.backgroundColor = .systemBackground
            
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemOtherInfoTableViewCell.identifier, for: indexPath) as? ItemOtherInfoTableViewCell else { return UITableViewCell() }
            
            cell.configure(withViewData: othersInfos)
            cell.selectionStyle = .none
            cell.backgroundColor = .systemBackground
            
            return cell
        case .shipping:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemShippingInfoTableViewCell.identifier, for: indexPath) as? ItemShippingInfoTableViewCell else { return UITableViewCell() }
            
            cell.configure()
            cell.selectionStyle = .none
            cell.backgroundColor = .systemBackground
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            navigateToItemDetailsPage()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch rowTypes[indexPath.row] {
        case .item:
            return 410
        case .size:
            return 120
        case .other:
            return 270
        case .shipping:
            return 100
        }
    }
}


extension ItemViewController: ItemViewModelToViewController {
    func loadingIndicator(isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? CustomLoadingIndicatorView.sharedInstance.showBlurView(withTitle: "Please Wait...") : CustomLoadingIndicatorView.sharedInstance.hide()
        }
    }
    
    func updateView(for data: ProductInfo, withRowTypes rowRypes: [ProductRowType], otherInfoCellData: [OtherInfoCellViewModel]) {
        DispatchQueue.main.async {[weak self] in
            self?.rowTypes = rowRypes
            self?.itemSizeAndColrInfo = data.size
            self?.itemInfo = data.item
            self?.othersInfos = otherInfoCellData
            self?.tableView.reloadData()
        }
    }
}


extension ItemViewController: ItemSizeAndColorInfoTableViewCellDelegate {
    func itemTapped() {
        navigateToItemDetailsPage()
    }
}
