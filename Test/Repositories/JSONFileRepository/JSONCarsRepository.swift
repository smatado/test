//
//  JSONCarsRepository.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation
import Combine

enum CarRepositoryError: Error {
    case repositoryDeallocated
    case fileNotExisting
    case loadingFailed(error: Error)
}

class CarsRepository: CarsRepositoryProtocol {
    
    var cars: AnyPublisher<[Car], CarRepositoryError> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else {
                    promise(.failure(.repositoryDeallocated))
                    return
                }
                let result = self.loadCarsFromFile(named: "car_list")
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    
    private var cache: [Car]?
    
    func loadCarsFromFile(named name: String) -> Result<[Car], CarRepositoryError> {
        if let cars = cache {
            return .success(cars)
        }
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return .failure(CarRepositoryError.fileNotExisting)
        }

        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let carDTOs = try JSONDecoder().decode([CarDTO].self, from: data)
            let cars = carDTOs.map { $0.toEntity() }
            cache = cars
            return .success(cars)
        } catch {
            return .failure(.loadingFailed(error: error))
        }
    }
}
