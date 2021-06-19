//
//  ProductViewControllerViewModel.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import Foundation

class ProductViewControllerViewModel: ProductViewControllerToViewModel {
    var router: ProductViewModelToRouter?
    
    var view: ProductViewModelToViewController?
    
    func getData() {
        view?.loadingIndicator(isLoading: true)
        let products = [
            ProductViewDescription(imageName: "item1", description: "TUINANLE Sandals One with dress Women 2021 New  Edition", price: "2850"),
            ProductViewDescription(imageName: "item2", description: "TUINANLE Sandals Two with complete dress Women 2021 New  Edition", price: "2850"),
            ProductViewDescription(imageName: "item3", description: "TUINANLE Sandals Three Women 2021 New  Edition", price: "2850")
        ]
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: { [weak self] in
            self?.view?.updateView(withProductData: products)
            self?.view?.loadingIndicator(isLoading: false)
        })
        
        
    }
}
