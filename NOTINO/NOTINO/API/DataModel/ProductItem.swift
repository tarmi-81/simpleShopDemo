//
//  ProductItem.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 04/09/2022.
//

import Foundation

struct ProductItem: Codable {
    let productId : Int
    let brand: BrandItem
    let attributes: AttributesItem
    let annotation: String
    let masterId: Int
    let url: String
    let price: PriceItem
    let imageUrl: String
    let name: String
    let productCode: String
    let reviewSummary : ReviewSummaryItem
    let stockAvailability : StockAvailabilityItem
}
