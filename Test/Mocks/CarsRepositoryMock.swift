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
    
    var cars: AnyPublisher<[Car], CarRepositoryError> {
        switch mockTestCase {
        case .success(let output):
            return Just(output)
                .setFailureType(to: CarRepositoryError.self)
                .eraseToAnyPublisher()
        case .failure:
            return Fail(error: CarRepositoryError.loadingFailed(error: nil))
                .eraseToAnyPublisher()
        }
    }
}
