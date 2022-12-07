//
//  CarManagedObject+Extensions.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation

extension CarManagedObject: EntityConvertible {
    typealias T = Car

    func toEntity() -> Car {
        return Car(
            id: id ?? UUID().uuidString,
            make: make ?? "",
            model: model ?? "",
            price: price,
            imageName: make ?? "", // We use the make as image name here
            rating: Int(rating),
            pros: pros ?? [],
            cons: cons ?? []
        )
    }
}
