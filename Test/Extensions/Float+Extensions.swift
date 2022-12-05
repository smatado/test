//
//  Float+Extensions.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation

extension Float {
    var formattedPrice: String {
        let thousands = Int(self) / 1000
        if thousands >= 1 {
            return "\(thousands)k"
        } else {
            return "\(self)"
        }
    }
}


