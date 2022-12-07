//
//  Filter.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-06.
//

import SwiftUI

struct Filter: View {
    
    var title: String
    var items: [String?]
    var selected: Binding<String?>
    var displayed: Binding<Bool>
    
    var body: some View {
        if displayed.wrappedValue {
            filterPicker(items: items, selected: selected, displayed: displayed)
        } else {
            filterButton(title: title, displayed: displayed)
        }
    }
    
    @ViewBuilder
    private func filterButton(title: String, displayed: Binding<Bool>) -> some View {
        Button(action: {
            withAnimation {
                displayed.wrappedValue = true
            }
        }, label: {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.black)
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
                        .foregroundColor(.black)
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
}
