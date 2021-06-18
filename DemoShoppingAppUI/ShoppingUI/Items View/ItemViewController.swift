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
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
        
        return table
    }()
    
    private let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 0
        
        return stack
    }()
    
    private let leftBottomAddToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.setImage(UIImage(named: "addTocart"), for: .normal)
        button.backgroundColor = UIColor(hexString: "#E9FFF5")
        
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
    
    private let rowTypes: [ProductRowType] = [.item, .size, .other]
    
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
            bottomMiddleAddToCartButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2-30),
            bottomRightBuyButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2-30)
        ])
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
            let data = ItemInfo(img: "item1", actualPrice: "2850", discountedPrice: "3050", isFavourite: false, disCountedPercent: "25%", description: "TUINANLE Sandals Women 2020 New Sexy Open-toed Sandals Wedge Outdoor Cool Platform Shoes Ladies Beach Summer Sandalia Feminina", rating: "4.8", ratingByCount: 85, reviewsCount: 98, ordersCount: 80)
            cell.configure(with: data)
            cell.backgroundColor = .systemBackground
            
            return cell
        case .size:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemSizeAndColorInfoTableViewCell.identifier, for: indexPath) as? ItemSizeAndColorInfoTableViewCell else { return UITableViewCell() }
            cell.configure(withDataModel: ItemSizeAndColor(availableColorCount: 2, availableSizeCount: 4, title: nil, availableResourceImageNames: ["sandel1","sandel2","sandel3","sandel4","sandel5"], avaiLabelItemText: nil))
            cell.backgroundColor = .systemBackground
            
            return cell
        case .other:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemOtherInfoTableViewCell.identifier, for: indexPath) as? ItemOtherInfoTableViewCell else { return UITableViewCell() }
            
            
            cell.configure(withViewData: getOtherCellData())
            
            cell.backgroundColor = .systemBackground
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let detailView = ItemsDetailViewController()
            detailView.title = "Items Detail Size"
            self.navigationController?.pushViewController(detailView, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func getOtherCellData() -> [OtherInfoCellViewModel] {
        let items = [
            OtherInfoCellViewModel(leftIconName: "spec", text: "Specification", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "review", text: "Reviews", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "order", text: "How To Order", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "faq", text: "FAQ", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "sale", text: "Wholesale Enquiry", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "description", text: "Description", rightIconName: "chevron.right"),
        ]
        return items
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch rowTypes[indexPath.row] {
        case .item:
            return 410
        case .size:
            return 120
        case .other:
            return 270
        default:
            return 100
        }
    }
}
