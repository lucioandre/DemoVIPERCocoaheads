//
// Created by Lucio
// Copyright (c) 2017 Company. All rights reserved.
//

import Foundation
import Unbox

class ProductListAPIDataManager: ProductListAPIDataManagerInputProtocol {

    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?

    init() {}

    func getProducts(completion: @escaping ([ProductListItem]?, Error?) -> Void) {
        dataTask?.cancel()
        if let url = URL(string: "https://demo8129738.mockable.io/products") {
            dataTask = defaultSession.dataTask(with: url, completionHandler: { (data, response, error) in
                //defer { self.dataTask = nil }

                if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {

                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [UnboxableDictionary] {
                            let products: [ProductListItem] = try unbox(dictionaries: json)
                            DispatchQueue.main.async {
                                completion(products, nil)
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                completion(nil, APIErrors.JSONParseFailed)
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(nil, APIErrors.JSONParseFailed)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, APIErrors.ConnectionFailed)
                    }
                }
            })
            dataTask?.resume()
        }
    }
}
