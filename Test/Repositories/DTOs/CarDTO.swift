//
//  CarDTO.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

struct CarDTO: Decodable {
    let make: String
    let model: String

    let customerPrice: Float
    let marketPrice: Float

    let rating: Int

    let prosList: [String]
    let consList: [String]
}

extension CarDTO: EntityConvertible {
    typealias T = Car
    
    func toEntity() -> Car {
        return Car(
            make: make,
            model: model,
            price: customerPrice,
            imageName: make, // We use the make as image name here
            rating: rating,
            pros: prosList.filter { $0 != ""},
            cons: consList.filter { $0 != ""}
        )
    }
}
