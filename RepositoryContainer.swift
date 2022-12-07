//
//  RepositoryContainer.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation

class RepositoryContainer {
    static var shared: CarsRepositoryProtocol {
        CarsRepository(
            persistenceRepository: CoreDataCarsRepository(coreDataStack: CoreDataStack(named: "Cars")),
            fileRepository: JSONCarsRepository()
        )
    }
}
