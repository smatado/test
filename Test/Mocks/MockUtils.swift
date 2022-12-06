//
//  MockUtils.swift
//  TestTests
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import Foundation

enum MockTestCase<T> {
    case success(output: T)
    case failure
}

enum MockError: Error {
    case mock
}
