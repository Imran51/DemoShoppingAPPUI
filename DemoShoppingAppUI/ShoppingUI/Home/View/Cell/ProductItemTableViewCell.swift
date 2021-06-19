//
//  ProductItemTableViewCell.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import UIKit

class ProductItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductItemCollectionViewCell"
    
    private static let fontSize: CGFloat = 15
    
    private let itemImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image.heightAnchor.constraint(equalToConstant: 80).isActive = true
        image.round(cornerRadius: 40, borderColor: .label)
        
        return image
    }()
    
    private let parentView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private let containerStackView = ViewUtils.customStackview(withSpacing: 5, withAlignment: .center, withAxis: .vertical)
    
    private let itemDescLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        
        return label
    }()
    
    private let itemPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: fontSize, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .systemBlue
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(parentView)
        parentView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(itemImageView)
        containerStackView.addArrangedSubview(itemDescLabel)
        containerStackView.addArrangedSubview(itemPriceLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerStackView.isLayoutMarginsRelativeArrangement = true
        containerStackView.layoutMargins = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            parentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            parentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            containerStackView.topAnchor.constraint(equalTo: parentView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ProductViewDescription){
        itemImageView.image = UIImage(named: viewModel.imageName)
        itemDescLabel.text = viewModel.description
        itemPriceLabel.text = "BDT. " + formattedBDTPrice(Double(viewModel.price) ?? 0)
    }
    
    private func formattedBDTPrice(_ price: Double) -> String {
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
