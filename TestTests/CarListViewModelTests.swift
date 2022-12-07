//
//  TestTests.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import XCTest
@testable import Test
import Combine

final class CarListViewModelTests: XCTestCase {

    lazy var carsRepositoryMock = CarsRepositoryMock(mockTestCase: .success(output: []))
    lazy var carListViewModel = CarListViewModel(carsRepository: carsRepositoryMock)
    var cancellables = Set<AnyCancellable>()
    
    func testLoadCars() throws {
        let expectation = self.expectation(description: "testLoadCars")
        
        // GIVEN
        carsRepositoryMock.mockTestCase = .success(output: CarsMock.shared)
        
        // WHEN
        carListViewModel.$carList
            .sink(receiveCompletion: { _ in }, receiveValue: { cars in
                // Avoid the first event with empty array initial value
                if cars.count > 0 {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        // THEN
        waitForExpectations(timeout: 3)
        XCTAssertEqual(CarsMock.shared.map { "\($0.make) \($0.model)" },
                       carListViewModel.carList.map { $0.name })
    }
    
    func testLoadCarsWithMakeFilter() throws {
        let expectation = self.expectation(description: "testLoadCarsWithMakeFilter")
        
        // GIVEN
        carsRepositoryMock.mockTestCase = .success(output: CarsMock.shared)
        carListViewModel.selectedMake("BMW")

        // WHEN
        carListViewModel.$carList
            .sink(receiveCompletion: { _ in }, receiveValue: { cars in
                // Avoid the initial event with all the cars
                if cars.count == 1 {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        
        // THEN
        waitForExpectations(timeout: 3)
        XCTAssertEqual(carListViewModel.carList.map { $0.name }, ["BMW M3"])
    }
    
    func testLoadCarsWithModelFilter() throws {
        let expectation = self.expectation(description: "testLoadCarsWithModelFilter")
        
        // GIVEN
        carsRepositoryMock.mockTestCase = .success(output: CarsMock.shared)
        carListViewModel.selectedModel("Blazer")

        // WHEN
        carListViewModel.$carList
            .sink(receiveCompletion: { _ in }, receiveValue: { cars in
                // Avoid the initial event with all the cars
                if cars.count == 1 {
                    expectation.fulfill()
                }
            })
            .store(in: &cancellables)
        
        
        // THEN
        waitForExpectations(timeout: 3)
        XCTAssertEqual(carListViewModel.carList.map { $0.name }, ["Chevrolet Blazer"])
    }
}
