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
        collapsedContent
    }
    
    private var collapsedContent: some View {
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
        .padding()
        .background(Color.guidomiaLightGrey)
    }
}

struct CarRow_Previews: PreviewProvider {
    static var previews: some View {
        CarListView(viewModel: CarListViewModel())
    }
}
