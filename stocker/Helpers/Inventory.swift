//
//  Products.swift
//  stocker
//
//  Created by Setthasit Poosawat on 14/11/2564 BE.
//

import Foundation

struct Inventory {
    struct Categories {
        let category:String
        let productName:String
        struct Products {
            let item:String
            let quantity:Int
            let price:Float
        }
    }
}
