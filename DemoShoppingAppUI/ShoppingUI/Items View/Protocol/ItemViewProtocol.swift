//
//  ItemViewProtocol.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 15/6/21.
//

import UIKit

protocol ItemViewModelToViewController: AnyObject {
    var viewModel: ItemViewControllerToViewModel? { get set }
    
    func updateView(for data: ProductInfo, withRowTypes rowRypes: [ProductRowType], otherInfoCellData: [OtherInfoCellViewModel])
    
    func loadingIndicator(isLoading: Bool)
}

protocol ItemViewModelToRouter: AnyObject {
    static func start() -> ItemViewController
    
    func showViewController(from nav: UINavigationController)
}

protocol ItemViewControllerToViewModel: AnyObject {
    var router: ItemViewModelToRouter? { get set }
    
    var view: ItemViewModelToViewController? { get set }
    
    func getData()
}

