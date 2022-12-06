//
//  ContentView.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

struct CarListView<ViewModelType: CarListViewModelProtocol & ObservableObject>: View {
    
    @State var expandedRowId: String?
    
    @State var isMakePickerDisplayed: Bool = false
    @State var isModelPickerDisplayed: Bool = false
    
    @State var selectedMake: String?
    @State var selectedModel: String?

    @ObservedObject var viewModel: ViewModelType

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0.0) {
                filters()
                ForEach(viewModel.carList) { carViewModel in
                    let isExpanded = expandedRowId == carViewModel.id
                    Group {
                        CarRow(carViewModel, isExpanded: isExpanded)
                            .padding()
                        if isExpanded {
                            VStack(alignment: .leading, spacing: 0.0) {
                                if carViewModel.pros.count > 0 {
                                    reviewDetails(title: "Pros :", reviews: carViewModel.pros)
                                }
                                if carViewModel.cons.count > 0 {
                                    reviewDetails(title: "Cons :", reviews: carViewModel.cons)
                                }
                            }
                        }
                        
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .background(Color.guidomiaLightGrey)
                    .onTapGesture {
                        withAnimation {
                            expandedRowId = isExpanded ? nil : carViewModel.id
                        }
                    }
                    Rectangle()
                        .foregroundColor(Color.guidomiaOrange)
                        .frame(height: .separatorHeight)
                        .padding(.mediumSpacing)
                }
            }
            .animation(.default, value: viewModel.carList)
        }
        .onAppear {
            self.expandedRowId = viewModel.carList.first?.id
        }
    }

    @ViewBuilder
    private func filters() -> some View {
        VStack(alignment: .leading) {
            Text("Filters")
                .foregroundColor(.white)
            Group {
                filter(
                    title: selectedMake ?? "Any Make",
                    items: viewModel.makes,
                    selected: $selectedMake,
                    displayed: $isMakePickerDisplayed
                )
                .onChange(of: selectedMake) {
                    // Seems overkill but compiler failed to produce a diagnostic when passed a binding to a publised property from the viewModel directly...
                    viewModel.selectedMake($0)
                }
                .bold()
                .foregroundColor(selectedMake == nil ? .guidomiaLightGrey : .black)
                filter(
                    title: selectedModel ?? "Any Model",
                    items: viewModel.models,
                    selected: $selectedModel,
                    displayed: $isModelPickerDisplayed
                )
                .onChange(of: selectedModel) {
                    // Seems overkill but compiler failed to produce a diagnostic when passed a binding to a publised property from the viewModel directly...
                    viewModel.selectedModel($0)
                }
                .bold()
                .foregroundColor(selectedModel == nil ? .guidomiaLightGrey : .black)
            }
            .padding(CGFloat.smallSpacing)
            .background(Color.white)
            .cornerRadius(CGFloat.smallSpacing)
            .shadow(
                color: Color.black,
                radius: CGSize.shadowSize.width,
                x: CGSize.shadowSize.width, y: CGSize.shadowSize.height
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.guidomiaDarkGrey)
        .cornerRadius(8.0)
        .padding()
    }
    
    @ViewBuilder
    private func filter(title: String,
                        items: [String?],
                        selected: Binding<String?>,
                        displayed: Binding<Bool>
                        ) -> some View {
        if displayed.wrappedValue {
            filterPicker(items: items, selected: selected, displayed: displayed)
        } else {
            filterButton(title: title, displayed: displayed)
        }
    }
    
    @ViewBuilder
    private func filterButton(title: String,
                              displayed: Binding<Bool>) -> some View {
        Button(action: {
            withAnimation {
                displayed.wrappedValue = true
            }
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
        })
    }

    @ViewBuilder
    private func filterPicker(items: [String?],
                              selected: Binding<String?>,
                              displayed: Binding<Bool>) -> some View {
        VStack(alignment: .leading) {
            Text(selected.wrappedValue ?? "Any Make")
                .bold()
                .foregroundColor(selected.wrappedValue == nil ? .guidomiaLightGrey : .black)
            Picker("", selection: selected) {
                ForEach(items, id: \.self) { make in
                    Text(make ?? "Any Model")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onTapGesture {
            withAnimation {
                displayed.wrappedValue = false
            }
        }
    }

    @ViewBuilder
    private func reviewDetails(title: String, reviews: [String]) -> some View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView<CarListViewModel>(viewModel: CarListViewModel(carsRepository: CarsRepository()))
    }
}
