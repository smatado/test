//
//  CarRowViewModel.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

struct CarRowViewModel: Identifiable {
    var id: String = UUID().uuidString
    let name: String
    let price: String
    let imageName: String
    let rating: Int
}
