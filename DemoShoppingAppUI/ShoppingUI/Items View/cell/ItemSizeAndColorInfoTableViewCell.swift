//
//  ItemSizeAndColorInfoTableViewCell.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 15/6/21.
//

import UIKit

class ItemSizeAndColorInfoTableViewCell: UITableViewCell {
    static let identifier = "ItemSizeAndColorInfoTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: TileCollectionViewCell.identifier)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.allowsMultipleSelection = false
        
        return collectionView
    }()
    
    private var imageReSourceData: [String]?
    private var textResourceData: [String]?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            label.heightAnchor.constraint(equalToConstant: 30),
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(withDataModel model: ItemSizeAndColor) {
        if let imageList = model.availableResourceImageNames {
            if let colorCount = model.availableColorCount {
                label.text = "\(model.availableColorCount ?? 0)" + " Color" + ", " + "\(model.availableSizeCount ?? 0)" + " Size"
            } else {
                label.text = model.title
            }
            
            imageReSourceData = imageList
        } else if let textList = model.avaiLabelItemText {
            label.text = model.title
            textResourceData = textList
            
        }
        collectionView.reloadData()
        
    }
}

extension ItemSizeAndColorInfoTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = imageReSourceData {
            return data.count
        } else if let textData = textResourceData {
            return textData.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TileCollectionViewCell.identifier, for: indexPath) as? TileCollectionViewCell else { return UICollectionViewCell() }
        if let data = imageReSourceData {
            cell.configure(with: TileCollectionViewCellViewModel(imageResourceName: data[indexPath.row], itemLabelText: nil))
        } else if let textData = textResourceData {
            cell.configure(with: TileCollectionViewCellViewModel(imageResourceName:nil, itemLabelText: textData[indexPath.row]))
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = 50
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.cornerRadius = 6.0
        cell?.layer.borderWidth = 1.5
        cell?.layer.borderColor = UIColor.green.cgColor
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.cornerRadius = 6.0
        cell?.layer.borderWidth = 1.5
        cell?.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
}
