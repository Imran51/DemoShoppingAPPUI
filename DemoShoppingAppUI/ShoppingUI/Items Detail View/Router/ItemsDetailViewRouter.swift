//
//  File.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import UIKit

class ItemsDetailViewRouter: ItemsDetailViewModelToRouter {
    static func start() -> ItemsDetailViewController {
        let router = ItemsDetailViewRouter()
        let viewModel: ItemsDetailViewControllerToViewModel = ItemsDetailViewViewModel()
        let viewController = ItemsDetailViewController()
        viewController.title = "Detail Size and Color"
        
        viewController.viewModel = viewModel
        
        viewModel.router = router
        viewModel.view = viewController
        
        return viewController
    }
    
    func showViewController(from nav: UINavigationController) {
        // some implementation goes here
    }
}
