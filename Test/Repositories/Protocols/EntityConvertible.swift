//
//  EntityConvertible.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

protocol EntityConvertible {
    associatedtype T
    func toEntity() -> T
}
