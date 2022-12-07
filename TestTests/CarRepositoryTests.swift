//
//  CarRepositoryTests.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import XCTest
import Combine
@testable import Test

final class CarsRepositoryTests: XCTestCase {
    
    var carsRepository: CarsRepository?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        carsRepository = CarsRepository(
            persistenceRepository: CoreDataCarsRepository(coreDataStack: CoreDataStack(named: "Cars")),
            fileRepository: JSONCarsRepository()
        )
    }

    func testFetch() throws {
        let expectation = self.expectation(description: "testFetch")

        // GIVEN
        var receivedCars: [Car]? = nil

        // WHEN
        carsRepository?.cars
            .replaceError(with: [])
            .sink(receiveValue: { cars in
                receivedCars = cars
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // THEN
        waitForExpectations(timeout: 3)
        XCTAssertFalse(receivedCars?.isEmpty ?? true)
    }
}
