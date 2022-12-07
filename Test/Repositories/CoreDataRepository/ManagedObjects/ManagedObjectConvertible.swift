//
//  ManagedObjectConvertible.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation
import CoreData

protocol ManagedObjectConvertible {
    associatedtype T: NSManagedObject
    func toManagedObject(context: NSManagedObjectContext) -> T
}
