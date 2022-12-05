//
//  CarRepository.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation
import Combine

protocol CarsRepositoryProtocol {
    var cars: AnyPublisher<[Car], CarRepositoryError> { get }
}
