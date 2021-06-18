//
//  ItemShippingInfoTableViewCell.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 18/6/21.
//

import UIKit

class ItemShippingInfoTableViewCell: UITableViewCell {
    static let identifier = "ItemShippingInfoTableViewCell"
    
    private let titlehorizotalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        return label
    }()
    
    private let rightEstimatedDeliveryabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .quaternaryLabel
        label.textAlignment = .right
        
        return label
    }()
    
    private let leftIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shipping")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlehorizotalStackView)
        
        titlehorizotalStackView.addArrangedSubview(leftIcon)
        titlehorizotalStackView.addArrangedSubview(leftTitleLabel)
        titlehorizotalStackView.addArrangedSubview(rightEstimatedDeliveryabel)
        
//        contentView.addSubview(itemDescriptionVerticalStackView)
//        itemDescriptionVerticalStackView.addArrangedSubview(itemDescriptionLabel)
//        itemDescriptionVerticalStackView.addArrangedSubview(ratingWithOtherInfoLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titlehorizotalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlehorizotalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlehorizotalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titlehorizotalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
