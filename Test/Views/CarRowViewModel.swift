//
//  CarRowViewModel.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

struct CarRowViewModel: Identifiable {
    
    var id: String
    let name: String
    let price: String
    let imageName: String
    let rating: Int
    
    init(car: Car) {
        id = car.id
        name = "\(car.make) \(car.model)"
        price = "\(String.priceLabel): \(car.price.formattedPrice)"
        imageName = car.imageName
        rating = car.rating
    }
}
