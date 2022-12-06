//
//  CarListViewModelProtocol.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

protocol CarListViewModelProtocol {
    var carList: [CarRowViewModel] { get }
    
    var makes: [String?] { get }
    var models: [String?] { get }
    
    func selectedMake(_ make: String?)
    func selectedModel(_ model: String?)
}
