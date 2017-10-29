//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation
import Unbox

struct ProductListItem {
    let title: String
    let description: String
    let price: Double
    let rating: Double
    let image: String
}

extension ProductListItem: Unboxable {
    init(unboxer: Unboxer) throws {
        self.title = try unboxer.unbox(key: "title")
        self.description = try unboxer.unbox(key: "description")
        self.price = try unboxer.unbox(key: "price")
        self.rating = try unboxer.unbox(keyPath: "rating")
        self.image = try unboxer.unbox(key: "image")
    }
}
