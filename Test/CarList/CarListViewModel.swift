//
//  CarListViewModel.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation
import Combine

class CarListViewModel: CarListViewModelProtocol, ObservableObject {
    
    // MARK: - Published properties
    
    @Published var carList = [CarRowViewModel]()
    
    // MARK: - Private properties
    
    private var carsRepository: CarsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(carsRepository: CarsRepositoryProtocol) {
        self.carsRepository = carsRepository
        
        carsRepository.cars
            .subscribe(on: DispatchQueue.global())
            .replaceError(with: [])
            .map { cars in
                return cars.map { CarRowViewModel(car: $0) }
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.carList, on: self)
            .store(in: &cancellables)
    }
}
