//
//  CarListViewModel.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

class CarListViewModel: CarListViewModelProtocol, ObservableObject {
    
    // MARK: - Published properties
    
    @Published var carList = [CarRowViewModel]()
    
    // MARK: - Initializers
    
    init() {
        
        // Mocked data
        self.carList = [
            CarRowViewModel(
                car: Car(
                    name: "Alpine Roadster",
                    price: 120_000,
                    imageName: ImageNames.alpineRoadster,
                    rating: 5
                )
            ),
            CarRowViewModel(
                car: Car(
                    name: "Range Rover",
                    price: 65_000,
                    imageName: ImageNames.rangeRover,
                    rating: 4
                )
            ),
            CarRowViewModel(
                car: Car(
                    name: "BMW 330i",
                    price: 55_000,
                    imageName: ImageNames.marcedezBenzGLC,
                    rating: 3
                )
            ),
            CarRowViewModel(
                car: Car(
                    name: "Mercedez benz",
                    price: 54_000,
                    imageName: ImageNames.rangeRover,
                    rating: 0
                )
            ),
        ]
    }
}
