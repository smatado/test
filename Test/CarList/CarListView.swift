//
//  ContentView.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI


struct CarListView: View {
    
    @State var carsMock: [CarRowViewModel] = [
        CarRowViewModel(name: "Alfa Romeo", price: "50.000$"),
        CarRowViewModel(name: "BMW", price: "80.000$"),
        CarRowViewModel(name: "Chevrolet", price: "35.000$"),
    ]
        
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(carsMock) { carViewModel in
                    CarRow(carViewModel)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
