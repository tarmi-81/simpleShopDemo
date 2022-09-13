//
//  AttributesItem.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 04/09/2022.
//

import Foundation
struct AttributesItem: Codable {
    let Master : Bool
    let AirTransportDisallowed : Bool?
    let FreeDelivery : Bool?
    let PackageSize : PackageSizeItem
    
}
