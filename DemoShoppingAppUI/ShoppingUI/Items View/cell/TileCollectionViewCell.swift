//
//  TileCollectionViewCell.swift
//  CarouselCollectionViewDemo
//
//  Created by Imran Sayeed on 6/5/21.
//

import UIKit

struct TileCollectionViewCellViewModel {
    let imageResourceName: String?
    let itemLabelText: String?
}

protocol TileCollectionViewCellDelegate {
    func sizeLabelTapped()
}

class TileCollectionViewCell: UICollectionViewCell {
    static let identifier = "TileCollectionViewCell"
    
    private let itemImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let itemLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(itemImage)
        contentView.addSubview(itemLabel)
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        setupConstraints()
        itemImage.isHidden = true
        itemLabel.isHidden = true
        
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemImage.image = nil
        itemLabel.text = nil
    }
    
    
    
    @objc private func didTapLabel(_ sender: UITapGestureRecognizer) {
        
    }
    
    func configure(with viewModel: TileCollectionViewCellViewModel) {
        if let imageName = viewModel.imageResourceName {
            itemImage.isHidden = false
            itemLabel.isHidden = true
            itemImage.image = UIImage(named:imageName)
        } else if let itemLabelText = viewModel.itemLabelText {
            itemImage.isHidden = true
            itemLabel.isHidden = false
            itemLabel.text = itemLabelText
        }
    }
}
