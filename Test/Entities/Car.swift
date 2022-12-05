//
//  Car.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

struct Car {
    var id: String
    let name: String
    let price: Float
    let imageName: String
    let rating: Int
    let pros: [String]
    let cons: [String]
    
    init(id: String = UUID().uuidString, name: String, price: Float, imageName: String, rating: Int, pros: [String] = [], cons: [String] = []) {
        self.id = id
        self.name = name
        self.price = price
        self.imageName = imageName
        self.rating = rating
        self.pros = pros
        self.cons = cons
    }
}
