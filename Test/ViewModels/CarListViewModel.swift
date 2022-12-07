//
//  CarListViewModel.swift
//  Test
//
//  Created by Silbino Gonçalves Matado on 2022-12-05.
//

import Foundation
import Combine

class CarListViewModel: CarListViewModelProtocol, ObservableObject {
    
    // MARK: - Published properties
    
    @Published var carList = [CarRowViewModel]()
    @Published var makes = [String?]()
    @Published var models = [String?]()
    
    // MARK: - Private properties
    
    private let selectedMakeSubject = CurrentValueSubject<String?, Never>(nil)
    private let selectedModelSubject = CurrentValueSubject<String?, Never>(nil)

    private var carsRepository: CarsRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initializers
    
    init(carsRepository: CarsRepositoryProtocol) {
        self.carsRepository = carsRepository
        
        let carsShared = carsRepository
            .cars
            .subscribe(on: DispatchQueue.global())
            .share()
            .eraseToAnyPublisher()
                
        subscribeCarViewModels(carsPublisher: carsShared)
        subscribeMakeFilters(carsPublisher: carsShared)
        subscribeModelFilters(carsPublisher: carsShared)
    }
    
    // MARK: - Public func

    func selectedMake(_ make: String?) {
        selectedMakeSubject.send(make)
    }
    
    func selectedModel(_ model: String?) {
        selectedModelSubject.send(model)
    }

    // MARK: - Private func

    private func subscribeCarViewModels(carsPublisher: AnyPublisher<[Car], CarsRepositoryError>) {
        carsPublisher
            .replaceError(with: [])
            .combineLatest(selectedMakeSubject.eraseToAnyPublisher(), selectedModelSubject.eraseToAnyPublisher())
            .map { (cars, selectedMake, selectedModel) in
                cars
                    .filter {
                        guard let selectedMake = selectedMake else { return true }
                        return $0.make == selectedMake
                    }
                    .filter {
                        guard let selectedModel = selectedModel else { return true }
                        return $0.model == selectedModel
                    }
                    .map { CarRowViewModel(car: $0) }
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.carList, on: self)
            .store(in: &cancellables)
    }
    
    private func subscribeMakeFilters(carsPublisher: AnyPublisher<[Car], CarsRepositoryError>) {
        carsPublisher
            .replaceError(with: [])
            .map { cars in
                var models: [String?] = cars.map { $0.make }
                models.insert(nil, at: 0)
                return models
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.makes, on: self)
            .store(in: &cancellables)
    }

    private func subscribeModelFilters(carsPublisher: AnyPublisher<[Car], CarsRepositoryError>) {
        carsPublisher
            .replaceError(with: [])
            .map { cars in
                var models: [String?] = cars.map { $0.model }
                models.insert(nil, at: 0)
                return models
            }
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .assign(to: \.models, on: self)
            .store(in: &cancellables)
    }
}
