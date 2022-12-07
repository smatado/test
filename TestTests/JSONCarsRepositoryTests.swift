//
//  JSONCarsRepositoryTests.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import XCTest
import Combine
@testable import Test
final class JSONCarsRepositoryTests: XCTestCase {
    
    var carsRepository: JSONCarsRepository?
    var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        carsRepository = JSONCarsRepository()
    }

    func test_JSONFile_fetch() throws {
        let expectation = self.expectation(description: "test_JSONFile_fetch")

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
