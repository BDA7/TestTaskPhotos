//
//  SortInteractor.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 27.08.2023.
//

import Foundation

protocol SortInteractorPropsDelegate: AnyObject {
    var presenter: SortPresenterDelegate? { get set }
    var dataWorker: DataStoreWorkerFilterDelegate? { get set }
    var router: SortRouterDelegate? { get set }
}

protocol SortInteractorActionsDelegate: AnyObject {
    func applyFilters(min: String?, max: String?, title: String?)
    func rejectFilters()
}

final class SortInteractor: SortInteractorPropsDelegate {
    var presenter: SortPresenterDelegate?
    var dataWorker: DataStoreWorkerFilterDelegate?
    var router: SortRouterDelegate?
}

// MARK: - Filter Methods
extension SortInteractor: SortInteractorActionsDelegate {
    func applyFilters(min: String?, max: String?, title: String?) {
        dataWorker?.rejectFilters()
        var currentData = dataWorker?.getData()
        
        if let min = validateMinMax(min) {
            currentData = currentData?.filter({$0.id > min})
        }
        
        if let max = validateMinMax(max) {
            currentData = currentData?.filter({$0.id < max})
        }
        
        if let title = validateTitle(title?.lowercased()) {
            currentData = currentData?.filter({ picture in
                if picture.title.lowercased().contains(title) {
                    return true
                } else {
                    return false
                }
            })
        }
        
        guard let currentData = currentData else { return }
        dataWorker?.setFilteredData(currentData)
        router?.pop()
    }
    
    func rejectFilters() {
        dataWorker?.rejectFilters()
    }
}

// MARK: - Validate Methods
extension SortInteractor {
    private func validateMinMax(_ val: String?) -> Int? {
        guard let valString = val else { return nil }
        
        guard let valInt = Int(valString) else {
            router?.showAlert("Incorrect input")
            return nil
        }
        
        return valInt
    }
    
    private func validateTitle(_ title: String?) -> String? {
        if let title = title?.trimmingCharacters(in: .whitespacesAndNewlines), !title.isEmpty {
            return title
        }
        
        return nil
    }
}
