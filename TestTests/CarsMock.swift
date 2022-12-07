//
//  CarsMock.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
@testable import Test

class CarsMock {
    static var shared = [
        Car(make: "Alpine",
            model: "A610",
            price: 10_000,
            imageName: "",
            rating: 3
           ),
        Car(make: "BMW",
            model: "M3",
            price: 150_000,
            imageName: "",
            rating: 5
           ),
        Car(make: "Chevrolet",
            model: "Blazer",
            price: 50_000,
            imageName: "",
            rating: 4
           ),
    ]
}

