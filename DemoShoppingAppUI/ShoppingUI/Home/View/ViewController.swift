//
//  ViewController.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 14/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    private var itemsPerRow: CGFloat = 3
    private let cellHeight: CGFloat = 210
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.alwaysBounceVertical = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ProductItemCollectionViewCell.self, forCellWithReuseIdentifier: ProductItemCollectionViewCell.identifier)
        collection.backgroundColor = .systemBackground
        
        return collection
    }()
    
    var viewModel: ProductViewControllerToViewModel?
    private var products = [ProductViewDescription]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        checkFeasibleItemsPerRow()
        collectionView.delegate = self
        collectionView.dataSource = self
        setViewConstraint()
        viewModel?.getData()
    }
    
    private func checkFeasibleItemsPerRow() {
        if ViewUtils.isCurrentDeviceIphone() && ViewUtils.isDevicePortrait() {
            itemsPerRow = 2
        } else {
            itemsPerRow = 3
        }
    }

    private func setViewConstraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        checkFeasibleItemsPerRow()
        collectionView.collectionViewLayout.invalidateLayout()
        // Also try reloading your collection view to calculate the new constraints
        DispatchQueue.main.async{[weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension ViewController: ProductViewModelToViewController {
    func updateView(withProductData productData: [ProductViewDescription]) {
        DispatchQueue.main.async {[weak self] in
            self?.products = productData
            self?.collectionView.reloadData()
        }
    }
    
    func loadingIndicator(isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? CustomLoadingIndicatorView.sharedInstance.showBlurView(withTitle: "Please Wait...") : CustomLoadingIndicatorView.sharedInstance.hide()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCollectionViewCell.identifier, for: indexPath) as? ProductItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.item]
        
        cell.configure(with: product)
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
       
        guard let nav = self.navigationController else { return }
        viewModel?.router?.showViewController(from: nav)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: cellHeight)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}

