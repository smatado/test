//
//  ContentView.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

struct CarListView<ViewModelType: CarListViewModelProtocol & ObservableObject>: View {
    
    @State var expandedRowId: String?
    @ObservedObject var viewModel: ViewModelType

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                FiltersHeader(viewModel: viewModel)
                if viewModel.carList.isEmpty {
                    noResults()
                } else {
                    results()
                }
            }
            .animation(.default, value: viewModel.carList)
        }
        .onAppear {
            self.expandedRowId = viewModel.carList.first?.id
        }
    }
    
    @ViewBuilder
    private func noResults() -> some View {
        Text("No results for those criterias")
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    private func results() -> some View {
        ForEach(viewModel.carList) { carViewModel in
            let isExpanded = expandedRowId == carViewModel.id
            Group {
                CarRow(carViewModel, isExpanded: isExpanded)
                    .padding()
                if isExpanded {
                    VStack(alignment: .leading, spacing: 0.0) {
                        if carViewModel.pros.count > 0 {
                            CarRowExpandedDetail(title: "Pros :", reviews: carViewModel.pros)
                        }
                        if carViewModel.cons.count > 0 {
                            CarRowExpandedDetail(title: "Cons :", reviews: carViewModel.cons)
                        }
                    }
                }
            }
            .background(Color.guidomiaLightGrey)
            .onTapGesture {
                withAnimation {
                    expandedRowId = isExpanded ? nil : carViewModel.id
                }
            }
            separator()
        }
    }
    
    @ViewBuilder
    private func separator() -> some View {
        Rectangle()
            .foregroundColor(Color.guidomiaOrange)
            .frame(height: .separatorHeight)
            .padding(.mediumSpacing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView<CarListViewModel>(viewModel: CarListViewModel(carsRepository: CarsRepository()))
    }
}
