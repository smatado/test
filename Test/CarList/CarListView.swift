//
//  ContentView.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI


struct CarListView: View {
    
    @State var carsMock: [CarRowViewModel] = [
        CarRowViewModel(
            name: "Alpine Roadster",
            price: "Price: 120k",
            imageName: Image.alpineRoadster,
            rating: 5
        ),
        CarRowViewModel(
            name: "Range Rover",
            price: "Price: 65k",
            imageName: Image.rangeRover,
            rating: 4
        ),
        CarRowViewModel(
            name: "BMW 330i",
            price: "Price: 55k",
            imageName: Image.marcedezBenzGLC,
            rating: 3
        ),
        CarRowViewModel(
            name: "Mercedez benz",
            price: "Price: 54k",
            imageName: Image.rangeRover,
            rating: 0
        ),
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
