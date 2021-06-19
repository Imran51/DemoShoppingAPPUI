//
//  ProductItemModel.swift
//  DemoShoppingAppUI
//
//  Created by Imran Sayeed on 15/6/21.
//

import Foundation

struct ProductInfo: Codable {
    let item: ItemInfo?
    let size: ItemSizeAndColor?
    let shipping: ShippingInfo?
    let other: ItemOtherRelatedInfo?
}

struct ProductViewDescription {
    let imageName: String
    let description: String
    let price: String
}

struct ItemInfo: Codable {
    let img: String
    let actualPrice: String
    let discountedPrice: String
    let isFavourite: Bool
    let disCountedPercent: String
    let description: String
    let rating: String
    let ratingByCount: Int
    let reviewsCount: Int
    let ordersCount: Int
}

struct ItemSizeAndColor: Codable {
    let availableColorCount: Int?
    let availableSizeCount: Int?
    let title: String?
    let availableResourceImageNames: [String]?
    let avaiLabelItemText: [String]?
}

struct ShippingInfo: Codable {
    let esimatedDeliveryDays: String
    let totalCost: Int
    let type: String
}

struct ItemOtherRelatedInfo: Codable {
    let specification: [String]
    let reviews: [String]
    let howToOrder: [String]
    let faq: [String]
    let theWholeSaleEnquiry: [String]
    let description: [String]
    let relatedImage: [String]
}
