//
//  CarRow.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

struct CarRow: View {
    
    private let viewModel: CarRowViewModel

    init(_ viewModel: CarRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(viewModel.name)
            }
            Spacer()
        }
        .padding()
    }
}
