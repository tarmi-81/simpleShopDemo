//
//  ServerAPI.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 04/09/2022.
//

import Foundation

struct ServerAPI {
    enum URL:String {
        case productList = "https://my-json-server.typicode.com/cernfr1993/notino-assignment/db"
        case imageBase = "https://i.notino.com/detail_zoom/"
    }
        public static    func loadProducts(_ success: @escaping (Products) -> () ){
            if let url = URL.productList.url() {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        let jsonDecoder = JSONDecoder()
                        do {
                            let parsedJSON = try jsonDecoder.decode(Products.self, from: data)
                          //  debugPrint(parsedJSON)
                            success(parsedJSON)
                        } catch {
                            debugPrint(error)
                        }
                    }
                }.resume()
            }
            
            
        }
}
extension ServerAPI.URL {
    func url() -> URL? {
        return (URL(string: self.rawValue))
    }
    func string() -> String {
        return self.rawValue
    }
    
}
