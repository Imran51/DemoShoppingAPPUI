//
//  VerticalTileOtherInfoCollectionViewCell.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 16/6/21.
//

import UIKit

struct OtherInfoCellViewModel {
    let leftIconName: String
    let text: String
    let rightIconName: String
}

class VerticalTileOtherInfoCollectionViewCell: UICollectionViewCell {
    static let identifier = "VerticalTileOtherInfoCollectionViewCell"
    
    private let leftIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let rightIconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        return image
    }()
    
    private let parentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(parentStackView)
        parentStackView.addArrangedSubview(leftIconImage)
        parentStackView.addArrangedSubview(label)
        parentStackView.addArrangedSubview(rightIconImage)
        
//        contentView.layer.cornerRadius = 6.0
//        contentView.layer.borderWidth = 1.5
//        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: OtherInfoCellViewModel) {
        leftIconImage.image = UIImage(named: viewModel.leftIconName)
        label.text = viewModel.text
        rightIconImage.image = UIImage(systemName: viewModel.rightIconName)
        rightIconImage.tintColor = .systemGray
    }
}
