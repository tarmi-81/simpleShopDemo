//
//  ViewControllerModel.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 03/09/2022.
//

import Foundation
import UIKit

struct ProductWrapper{
    var productItem: ProductItem
    var userInteractionData: UserInteractionData
}
struct UserInteractionData {
    var isFavorite: Bool = false
    var isInBasket: Bool = false
}

extension ViewController {
    
    class ViewModel {
        private var productResponse: Products?
        var product: [ProductWrapper] = []
        let padding: CGFloat = 20
        func loadProducts(_ success: @escaping () -> () ){
            ServerAPI.loadProducts { products in
                self.productResponse = products
                self.proccessProducts(success)
            }
        }
        func cellWidth(_ screenWidth: CGFloat) -> CGFloat {
            return (((screenWidth - 2*padding) - 8)/2)
        }
        func cellHeight(_ screenHeight: CGFloat) -> CGFloat {
            return screenHeight*6/10
        }
        func productsCount()-> Int {
            return product.count
        }
        func dataForCell(_ index:Int ) -> ProductWrapper?{
            if index >= productsCount() {
                return nil
            } else {
                return product[index]
            }
        }
        func proccessProducts(_ success: @escaping () -> ()){
            product = []
            if let productResponse = productResponse {
                for item in productResponse.vpProductByIds {
                    product.append(ProductWrapper(productItem: item,
                                                  userInteractionData: UserInteractionData()))
                }
            }
            success()
            
        }
    }
}

