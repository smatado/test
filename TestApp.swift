//
//  TestApp.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import SwiftUI

@main
struct TestApp: App {
   
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CarListView(viewModel: CarListViewModel(carsRepository: RepositoryContainer.shared))
            }
        }
    }
}
