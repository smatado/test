//
//  CoreDataRepository.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
import CoreData
import Combine

class CoreDataCarsRepository: CarsRepositoryProtocol {
        
    private let entityName = "Car"
    private let coreDataStack: CoreDataStack
    private var anyCancellable = Set<AnyCancellable>()
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    var cars: AnyPublisher<[Car], CarsRepositoryError> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                self.fetch(promise: promise)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func save(cars: [Car]) -> AnyPublisher<Void, CarsRepositoryError> {
        Deferred {
            Future { [weak self] promise in
                guard let self = self else { return }
                self.save(cars: cars, promise: promise)
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func fetch(promise: @escaping Future<[Car], CarsRepositoryError>.Promise) {
        let fetchRequest = NSFetchRequest<CarManagedObject>(entityName: entityName)
        coreDataStack.backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            do {
                let carsMO = try self.coreDataStack.backgroundContext.fetch(fetchRequest)
                let cars = carsMO.map {
                    $0.toEntity()
                }
                promise(.success(cars))
            } catch {
                promise(.failure(.loadingFailed(error: error)))
            }
        }
    }

    private func save(cars: [Car], promise: @escaping Future<Void, CarsRepositoryError>.Promise) {
        coreDataStack.backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            
            for car in cars {
                _ = car.toManagedObject(context: self.coreDataStack.backgroundContext)
            }
            
            do {
                try self.coreDataStack.backgroundContext.save()
                promise(.success(()))
            } catch {
                promise(.failure(.saveFailed(error: error)))
            }
        }
    }
    
}
