//
//  ItemInfoTableViewCell.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 15/6/21.
//

import UIKit

class ItemInfoTableViewCell: UITableViewCell {
    static let identifier = "ItemInfoTableViewCell"
    private let itemImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()
    
    private let priceInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    private let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.textAlignment = .left
        label.widthAnchor.constraint(equalToConstant: 130).isActive = true
        
        return label
    }()
    
    
    
    private let originalPriceLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .quaternaryLabel
        
        label.textAlignment = .left
        
        return label
    }()
    
    private let discountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(hexString: "#008E47")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 13
        label.backgroundColor = UIColor(hexString: "#E9FFF5")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        return label
    }()
    
    private let favoriteIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return image
    }()
    
    private let shareIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "share")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 20).isActive = true
        image.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        return image
    }()
    
    private let itemDescriptionVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 10
        
        return stack
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private let ratingWithOtherInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .systemGreen
        label.textAlignment = .left
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(itemImage)
        contentView.addSubview(priceInfoStackView)
        
        priceInfoStackView.addArrangedSubview(discountedPriceLabel)
        priceInfoStackView.addArrangedSubview(originalPriceLabel)
        priceInfoStackView.addArrangedSubview(discountLabel)
        priceInfoStackView.addArrangedSubview(favoriteIcon)
        priceInfoStackView.addArrangedSubview(shareIcon)
        
        contentView.addSubview(itemDescriptionVerticalStackView)
        itemDescriptionVerticalStackView.addArrangedSubview(itemDescriptionLabel)
        itemDescriptionVerticalStackView.addArrangedSubview(ratingWithOtherInfoLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 220),
            priceInfoStackView.topAnchor.constraint(equalTo: itemImage.bottomAnchor),
            priceInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            priceInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            priceInfoStackView.heightAnchor.constraint(equalToConstant: 60),
            itemDescriptionVerticalStackView.topAnchor.constraint(equalTo: priceInfoStackView.bottomAnchor),
            itemDescriptionVerticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            itemDescriptionVerticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            itemDescriptionVerticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with viewData: ItemInfo) {
        itemImage.image = UIImage(named: viewData.img)
        discountedPriceLabel.text = "BDT. " + " " + df2so(Double(viewData.discountedPrice) ?? 0)
        originalPriceLabel.text = "BDT. " + df2so(Double(viewData.actualPrice) ?? 0)
        discountLabel.text = viewData.disCountedPercent
        itemDescriptionLabel.text = viewData.description
        ratingWithOtherInfoLabel.text = viewData.rating + " \u{2605}"
    }
    
    func df2so(_ price: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)!
    }
}
