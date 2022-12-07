//
//  CoreDataCarsRepositoryTests.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import XCTest
import Combine
@testable import Test

final class CoreDataCarsRepositoryTests: XCTestCase {
    
    var carsRepository: CoreDataCarsRepository?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        carsRepository = CoreDataCarsRepository(coreDataStack: CoreDataStack(named: "Cars"))
    }

    func test_coreData_fetch() throws {
        let expectation = self.expectation(description: "test_coreData_fetch")

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
    
    func test_coreData_save() throws {
        let expectation = self.expectation(description: "test_coreData_save")

        // GIVEN
        var receivedCars: [Car]? = nil

        // WHEN
        carsRepository?.save(cars: CarsMock.shared)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)

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
