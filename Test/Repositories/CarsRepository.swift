//
//  CarsRepository.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
import Combine

class CarsRepository: CarsRepositoryProtocol {
    
    private let persistenceRepository: CarsRepositoryProtocol
    private let fileRepository: CarsRepositoryProtocol
    
    init(persistenceRepository: CarsRepositoryProtocol, fileRepository: CarsRepositoryProtocol) {
        self.persistenceRepository = persistenceRepository
        self.fileRepository = fileRepository
    }
    
    var cars: AnyPublisher<[Car], CarsRepositoryError> {
        return persistenceRepository.cars
            .flatMap { [weak self] cars in
                guard let self = self else {
                    return Fail<[Car], CarsRepositoryError>(error: CarsRepositoryError.repositoryDeallocated).eraseToAnyPublisher()
                }
                
                if cars.isEmpty {
                    return self.fetchAndSaveCarsFromFile()
                } else {
                    return self.fetchCarsFromPersistedCache()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func save(cars: [Car]) -> AnyPublisher<Void, CarsRepositoryError> {
        Fail(error: CarsRepositoryError.operationNotPermitted).eraseToAnyPublisher()
    }
    
    private func fetchAndSaveCarsFromFile() -> AnyPublisher<[Car], CarsRepositoryError> {
        fileRepository.cars
            .flatMap { [weak self] cars in
                guard let self = self else {
                    return Fail<[Car], CarsRepositoryError>(error: CarsRepositoryError.repositoryDeallocated).eraseToAnyPublisher()
                }
                
                return self.persistenceRepository.save(cars: cars)
                    .map { cars }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func fetchCarsFromPersistedCache() -> AnyPublisher<[Car], CarsRepositoryError> {
        persistenceRepository.cars
    }
}
