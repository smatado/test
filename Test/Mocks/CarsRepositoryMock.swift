//
//  CarsRepositoryMock.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
import Combine

class CarsRepositoryMock: CarsRepositoryProtocol {
    
    var mockTestCase: MockTestCase<[Car]>
    
    init(mockTestCase: MockTestCase<[Car]>) {
        self.mockTestCase = mockTestCase
    }
    
    var cars: AnyPublisher<[Car], CarsRepositoryError> {
        switch mockTestCase {
        case .success(let output):
            return Just(output)
                .setFailureType(to: CarsRepositoryError.self)
                .eraseToAnyPublisher()
        case .failure:
            return Fail(error: CarsRepositoryError.loadingFailed(error: nil))
                .eraseToAnyPublisher()
        }
    }
    
    func save(cars: [Car]) -> AnyPublisher<Void, CarsRepositoryError> {
        return Empty<Void, CarsRepositoryError>().eraseToAnyPublisher()
    }
}
