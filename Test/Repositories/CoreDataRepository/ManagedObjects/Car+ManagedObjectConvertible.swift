//
//  Car+ManagedObjectConvertible.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
import CoreData

extension Car: ManagedObjectConvertible {
    typealias T = CarManagedObject

    func toManagedObject(context: NSManagedObjectContext) -> CarManagedObject {
        let carMO = CarManagedObject(context: context)
        carMO.id = id
        carMO.make = make
        carMO.model = model
        carMO.price = price
        carMO.rating = Int16(rating)
        carMO.pros = pros
        carMO.cons = cons
        return carMO
    }
}
