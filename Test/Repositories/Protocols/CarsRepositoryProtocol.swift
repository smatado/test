//
//  CarRepository.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation
import Combine

enum CarsRepositoryError: Error {
    case repositoryDeallocated
    case fileNotExisting
    case loadingFailed(error: Error?)
    case saveFailed(error: Error?)
    case operationNotPermitted
}

protocol CarsRepositoryProtocol {
    var cars: AnyPublisher<[Car], CarsRepositoryError> { get }
    func save(cars: [Car]) -> AnyPublisher<Void, CarsRepositoryError>
}
