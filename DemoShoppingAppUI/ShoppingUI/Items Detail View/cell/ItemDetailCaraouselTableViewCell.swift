//
//  ItemDetailCaraouselTableViewCell.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 18/6/21.
//

import UIKit

class ItemDetailCaraouselTableViewCell: UITableViewCell {
    static let identifier = "ItemDetailCaraouselTableViewCell"
    
    private let itemsTopContainerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 5
        
        return stack
    }()
    
    private let itemImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.layer.masksToBounds = true
        image.backgroundColor = .red
        //image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.imageView?.tintColor = .white
        button.backgroundColor = .darkGray
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.imageView?.tintColor = .white
        button.backgroundColor = .darkGray
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return button
    }()
    
    private var imageResourceArray = [String]()
    private var imageIndex = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(itemsTopContainerStackView)
        
        itemsTopContainerStackView.addArrangedSubview(leftButton)
        itemsTopContainerStackView.addArrangedSubview(itemImage)
        itemsTopContainerStackView.addArrangedSubview(rightButton)
        
        leftButton.addTarget(self, action: #selector(leftArrowbuttonClicked(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightArrowbuttonClicked(_:)), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemsTopContainerStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            itemsTopContainerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20),
            itemsTopContainerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            itemsTopContainerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    @objc private func leftArrowbuttonClicked(_ sender: UIButton) {
        
        if imageIndex == 0 {
            leftButton.alpha = 0.0
            return
        }
        
        imageIndex -= 1
        UIView.transition(with: itemImage, duration: 1.5, options: .curveEaseIn, animations: { [unowned self] in
            self.itemImage.image = UIImage(named: (self.imageResourceArray[self.imageIndex]))
        }, completion: {[unowned self] _ in
            if self.imageIndex == 0  {
                self.leftButton.alpha = 0.0
                return
            }
        })
        rightButton.alpha = 1
    }
    
    @objc private func rightArrowbuttonClicked(_ sender: UIButton) {
        if self.imageIndex == self.imageResourceArray.count-1  {
            self.rightButton.alpha = 0.0
            return
        }
        
        imageIndex += 1
        UIView.transition(with: itemImage, duration: 1.5, options: .curveEaseOut, animations: { [unowned self] in
            self.itemImage.image = UIImage(named: (self.imageResourceArray[self.imageIndex]))
        }, completion: { [unowned self] _ in
            if self.imageIndex == self.imageResourceArray.count-1  {
                self.rightButton.alpha = 0.0
                return
            }
        })
        leftButton.alpha = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageIndex =  0
        imageView?.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(imageResource: [String]) {
        imageResourceArray = imageResource
        imageIndex =  0
        leftButton.alpha = 0.0
        itemImage.image = UIImage(named: imageResourceArray[imageIndex])
    }
}
