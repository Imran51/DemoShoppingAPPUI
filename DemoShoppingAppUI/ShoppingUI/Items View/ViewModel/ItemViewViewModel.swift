//
//  ItemViewViewModel.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 15/6/21.
//

import Foundation

class ItemViewModel: ItemViewControllerToViewModel {
    var router: ItemViewModelToRouter?
    
    weak var view: ItemViewModelToViewController?
    
    
    func getData() {
        // some api call and data processing goes here
        view?.loadingIndicator(isLoading: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [unowned self] in
            let itemsInfo = ItemInfo(img: "item1", actualPrice: "2850", discountedPrice: "3050", isFavourite: false, disCountedPercent: "25%", description: "TUINANLE Sandals Women 2020 New Sexy Open-toed Sandals Wedge Outdoor Cool Platform Shoes Ladies Beach Summer Sandalia Feminina", rating: "4.8", ratingByCount: 85, reviewsCount: 98, ordersCount: 80)
            let itemsSizeInfo = ItemSizeAndColor(availableColorCount: 2, availableSizeCount: 4, title: nil, availableResourceImageNames: ["sandel1","sandel2","sandel3","sandel4","sandel5"], avaiLabelItemText: nil)
            self.view?.updateView(for: ProductInfo(item: itemsInfo, size: itemsSizeInfo, shipping: nil, other: nil), withRowTypes: [.item, .size, .shipping, .other], otherInfoCellData: getOtherCellData())
            view?.loadingIndicator(isLoading: false)
        })
        
    }
    
    private func getOtherCellData() -> [OtherInfoCellViewModel] {
        let items = [
            OtherInfoCellViewModel(leftIconName: "spec", text: "Specification", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "review", text: "Reviews", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "order", text: "How To Order", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "faq", text: "FAQ", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "sale", text: "Wholesale Enquiry", rightIconName: "chevron.right"),
            OtherInfoCellViewModel(leftIconName: "description", text: "Description", rightIconName: "chevron.right"),
        ]
        return items
    }
}
