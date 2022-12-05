//
//  ContentView.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

struct CarListView<ViewModelType: CarListViewModelProtocol & ObservableObject>: View {
    
    @ObservedObject var viewModel: ViewModelType
    @State var expandedRowId: String?
    
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
        }
        .onAppear {
            self.expandedRowId = viewModel.carList.first?.id
        }
    }
    
    private func filters() -> some View {
        VStack(alignment: .leading) {
            Text("Filters")
                .foregroundColor(.white)
            Group {
                Button(action: {
                    print("Filter 1 tapped")
                }, label: {
                    Text("Any make")
                        .frame(maxWidth: .infinity, alignment: .leading)
                })

                Button(action: {
                    print("Filter 2 tapped")
                }, label: {
                    Text("Any model")
                        .frame(maxWidth: .infinity, alignment: .leading)
                })
            }
            .bold()
            .foregroundColor(.guidomiaLightGrey)
            .padding(CGFloat.smallSpacing)
            .background(Color.white)
            .cornerRadius(CGFloat.smallSpacing)
            .shadow(
                color: Color.black,
                radius: CGSize.shadowSize.width,
                x: CGSize.shadowSize.width, y: CGSize.shadowSize.height)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.guidomiaDarkGrey)
        .cornerRadius(8.0)
        .padding()
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
