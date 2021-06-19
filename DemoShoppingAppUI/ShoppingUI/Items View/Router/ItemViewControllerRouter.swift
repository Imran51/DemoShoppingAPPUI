//
//  ItemViewControllerRouter.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import UIKit

class ItemViewControllerRouter: ItemViewModelToRouter {
    static func start() -> ItemViewController {
        let router = ItemViewControllerRouter()
        let viewModel: ItemViewControllerToViewModel = ItemViewModel()
        let viewController = ItemViewController()
        viewController.title = "Product Info"
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        return viewController
    }
    
    func showViewController(from nav: UINavigationController) {
        let detailView = ItemsDetailViewRouter.start()
        nav.pushViewController(detailView, animated: true)
    }
}
