//
//  ItemsDetailViewprotocol.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import UIKit

protocol ItemsDetailViewModelToViewController: AnyObject {
    var viewModel: ItemsDetailViewControllerToViewModel? { get set }
    
    func updateView(for rowTypes: [ItemsDetaiRowType],withImageResource resource: [String], withColorInfo colorInfo: ItemSizeAndColor, withSizeInfo sizeInfo: ItemSizeAndColor)
    
    func loadingIndicator(isLoading: Bool)
}

protocol ItemsDetailViewModelToRouter: AnyObject {
    static func start() -> ItemsDetailViewController
    
    func showViewController(from nav: UINavigationController)
}

protocol ItemsDetailViewControllerToViewModel: AnyObject {
    var router: ItemsDetailViewModelToRouter? { get set }
    
    var view: ItemsDetailViewModelToViewController? { get set }
    
    func getData()
}

