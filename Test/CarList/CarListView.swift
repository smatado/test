//
//  ContentView.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

struct CarListView<ViewModelType: CarListViewModelProtocol & ObservableObject>: View {
    
    @ObservedObject var viewModel: ViewModelType
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.carList) { carViewModel in
                    CarRow(carViewModel)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView<CarListViewModel>(viewModel: CarListViewModel(carsRepository: CarsRepository()))
    }
}
