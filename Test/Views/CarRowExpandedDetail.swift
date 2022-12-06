//
//  CarRowExpandedDetail.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import SwiftUI

struct CarRowExpandedDetail: View {

    let title: String
    let reviews: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(title)
                .padding(.leading, CGFloat.mediumSpacing)
                .font(.title2)
                .foregroundColor(.guidomiaText)
                .bold()
            ForEach(reviews, id: \.self) { review in
                Group {
                    Text("\u{2022} ")
                        .font(.title)
                        .bold()
                        .foregroundColor(.guidomiaOrange)
                    + Text(review)
                        .font(.title3)
                        .bold()
                        .foregroundColor(.bulletPointText)
                }
                .padding(.leading, CGFloat.mediumSpacing * 2)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}
