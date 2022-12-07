//
//  AdHeader.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import SwiftUI

struct AdHeader: View {
    var body: some View {
        Image("Tacoma")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading) {
                    Text("Tacoma 2021")
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    Text("ad_text".localized)
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                }
                .padding()
            }
    }
}

struct AdHeader_Previews: PreviewProvider {
    static var previews: some View {
        AdHeader()
    }
}
