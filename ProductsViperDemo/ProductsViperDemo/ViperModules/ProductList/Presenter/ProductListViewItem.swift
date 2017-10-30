//
//  ProductListViewItem.swift
//  ProductsViperDemo
//
//  Created by Avenue Brazil on 30/10/17.
//  Copyright © 2017 LucioFonseca. All rights reserved.
//

import Foundation

struct ProductListViewItem {
    let name: String
    let price: String
    let rating: String
    let imageURL: URL?

    init(name: String, price: Double, rating: Double, imageURLString: String) {
        self.name = name.uppercased()
        self.price = String(format: "$%.2f", arguments: [price])
        self.rating = String(format: "%.1f", arguments: [rating])
        self.imageURL = URL(string: imageURLString)
    }
}
