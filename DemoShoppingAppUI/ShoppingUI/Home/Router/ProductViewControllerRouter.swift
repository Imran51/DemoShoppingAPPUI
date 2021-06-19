//
//  ProductViewControllerRouter.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import UIKit

class ProductViewControllerRouter: ProductViewModelToRouter {
    static func start() -> ProductViewController {
        let router = ProductViewControllerRouter()
        let viewModel: ProductViewControllerToViewModel = ProductViewControllerViewModel()
        let viewController = ProductViewController()
        viewController.title = "Products"
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        return viewController
    }
    
    func showViewController(from nav: UINavigationController) {
        let view = ItemViewControllerRouter.start()
        nav.pushViewController(view, animated: true)
    }
}

