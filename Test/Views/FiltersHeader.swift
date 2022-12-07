//
//  FiltersHeader.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import SwiftUI

struct FiltersHeader<ViewModelType: CarListViewModelProtocol & ObservableObject>: View {
    
    @ObservedObject var viewModel: ViewModelType

    @State private var isMakePickerDisplayed: Bool = false
    @State private var isModelPickerDisplayed: Bool = false
    
    @State private var selectedMake: String?
    @State private var selectedModel: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text("filters".localized)
                .foregroundColor(.white)
            Group {
                makefilter()
                modelfilter()
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
    private func makefilter() -> some View {
        Filter(
            title: selectedMake ?? "any_make".localized,
            items: viewModel.makes,
            selected: $selectedMake,
            displayed: $isMakePickerDisplayed,
            defaultText: "any_make".localized
        )
        .onChange(of: selectedMake) {
            // This is overkill to observe this value while we could pass viewModel binding directly
            // For an unknown reason, the compiler 'failed to produce a result' when attempting that
            viewModel.selectedMake($0)
        }
        .bold()
        .foregroundColor(selectedMake == nil ? .guidomiaLightGrey : .black)
    }
    
    @ViewBuilder
    private func modelfilter() -> some View {
        Filter(
            title: selectedModel ?? "any_model".localized,
            items: viewModel.models,
            selected: $selectedModel,
            displayed: $isModelPickerDisplayed,
            defaultText: "any_model".localized
        )
        .onChange(of: selectedModel) {
            // This is overkill to observe this value while we could pass viewModel binding directly
            // For an unknown reason, the compiler 'failed to produce a result' when attempting that
            viewModel.selectedModel($0)
        }
        .bold()
        .foregroundColor(selectedModel == nil ? .guidomiaLightGrey : .black)
    }
}
