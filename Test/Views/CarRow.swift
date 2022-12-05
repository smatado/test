//
//  CarRow.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

struct CarRow: View {
    
    private let viewModel: CarRowViewModel
    private let isExpanded: Bool

    init(_ viewModel: CarRowViewModel, isExpanded: Bool) {
        self.viewModel = viewModel
        self.isExpanded = isExpanded
    }
        
    var body: some View {
        HStack(alignment: .top, spacing: CGFloat.mediumSpacing) {
            Image(viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: CGFloat.imageWidth)
            VStack(alignment: .leading) {
                Group {
                    Text(viewModel.name)
                        .font(.title2)
                    Text(viewModel.price)
                        .font(.title3)
                }
                .foregroundColor(.guidomiaText)
                .bold()
                if viewModel.rating > 0 {
                    HStack {
                        ForEach((0...viewModel.rating - 1), id: \.self) { _ in
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: CGSize.starSize.width, height: CGSize.starSize.height)
                                .foregroundColor(.guidomiaOrange)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct CarRow_Previews: PreviewProvider {
    static var previews: some View {
        CarListView(viewModel: CarListViewModel(carsRepository: CarsRepository()))
    }
}
