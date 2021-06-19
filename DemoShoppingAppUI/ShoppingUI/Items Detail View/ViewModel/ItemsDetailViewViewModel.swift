//
//  ItemsDetailViewViewModel.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 19/6/21.
//

import Foundation

class ItemsDetailViewViewModel: ItemsDetailViewControllerToViewModel {
    var router: ItemsDetailViewModelToRouter?
    
    weak var view: ItemsDetailViewModelToViewController?
    
    func getData() {
        view?.updateView(
            for: [.caraouselImage, .colorInfo, .sizeInfo, .shippingInfo],
            withImageResource: ["item1","item2","item3"],
            withColorInfo: ItemSizeAndColor(availableColorCount: nil, availableSizeCount: nil, title: "Color", availableResourceImageNames: ["sandel1","sandel2","sandel3","sandel4","sandel5"], avaiLabelItemText: nil),
            withSizeInfo: ItemSizeAndColor(availableColorCount: nil, availableSizeCount: nil, title: "Size", availableResourceImageNames: nil, avaiLabelItemText: ["S","M","XL","XXL"])
        )
    }
}
