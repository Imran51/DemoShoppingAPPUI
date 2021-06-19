//
//  ProductViewControllerProtocol.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import UIKit

protocol ProductViewModelToViewController: AnyObject {
    var viewModel: ProductViewControllerToViewModel? { get set }
    
    func updateView(withProductData productData: [ProductViewDescription])
    
    func loadingIndicator(isLoading: Bool)
}

protocol ProductViewModelToRouter: AnyObject {
    static func start() -> ViewController
    
    func showViewController(from nav: UINavigationController)
}

protocol ProductViewControllerToViewModel: AnyObject {
    var router: ProductViewModelToRouter? { get set }
    
    var view: ProductViewModelToViewController? { get set }
    
    func getData()
}

