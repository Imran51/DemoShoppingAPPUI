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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        
        return label
    }()
    
    private let rightEstimatedDeliveryabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .quaternaryLabel
        label.textAlignment = .right
        
        return label
    }()
    
    private let leftIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shipping")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 25).isActive = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let shippingCostPickerHorizotalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.quaternaryLabel.cgColor
        stack.layer.cornerRadius = 10
        stack.layer.masksToBounds = true
        
        return stack
    }()
    
    private let leftShippingCostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .label
        label.textAlignment = .left
        
        return label
    }()
    
    private let rightShippingCostLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .label
        label.textAlignment = .right
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titlehorizotalStackView)
        contentView.addSubview(shippingCostPickerHorizotalStackView)
        titlehorizotalStackView.addArrangedSubview(leftIcon)
        titlehorizotalStackView.addArrangedSubview(leftTitleLabel)
        titlehorizotalStackView.addArrangedSubview(rightEstimatedDeliveryabel)
        
        shippingCostPickerHorizotalStackView.addArrangedSubview(leftShippingCostLabel)
        shippingCostPickerHorizotalStackView.addArrangedSubview(rightShippingCostLabel)
        
        shippingCostPickerHorizotalStackView.isLayoutMarginsRelativeArrangement = true
        shippingCostPickerHorizotalStackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titlehorizotalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titlehorizotalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            titlehorizotalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            titlehorizotalStackView.heightAnchor.constraint(equalToConstant: 40),
            shippingCostPickerHorizotalStackView.topAnchor.constraint(equalTo: titlehorizotalStackView.bottomAnchor),
            shippingCostPickerHorizotalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            shippingCostPickerHorizotalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            shippingCostPickerHorizotalStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        leftTitleLabel.text = "Shipping:"
        rightEstimatedDeliveryabel.text = "Esimated Delivery 7-15 days"
        
        leftShippingCostLabel.text = "zDrop Premium Shipping"
        rightShippingCostLabel.text = "Cost BDT." + " 4000 " + "\u{25BC}"
        //25BC
    }
}
