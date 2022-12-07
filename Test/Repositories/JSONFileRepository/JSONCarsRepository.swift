//
//  JSONCarsRepository.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation
import Combine

class JSONCarsRepository: CarsRepositoryProtocol {
    
    var cars: AnyPublisher<[Car], CarsRepositoryError> {
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
    
    func save(cars: [Car]) -> AnyPublisher<Void, CarsRepositoryError> {
        Fail(error: CarsRepositoryError.operationNotPermitted).eraseToAnyPublisher()
    }
    
    private var cache: [Car]?
    
    private func loadCarsFromFile(named name: String) -> Result<[Car], CarsRepositoryError> {
        if let cars = cache {
            return .success(cars)
        }
        
        guard let path = Bundle.main.path(forResource: name, ofType: "json") else {
            return .failure(CarsRepositoryError.fileNotExisting)
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
