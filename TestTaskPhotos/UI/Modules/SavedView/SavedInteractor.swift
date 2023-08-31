//
//  SavedInteractor.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 30.08.2023.
//

import Foundation

protocol SavedInteractorPropsDelegate: AnyObject {
    var presenter: SavedPresenterDelegate? { get set }
    var router: SavedRouterDelegate? { get set }
    var realmWorker: RealmWorkerSpecialDelegate? { get set }
}

protocol SavedInteractorActionsDelegate: AnyObject {
    func getAllModels()
}

final class SavedInteractor: SavedInteractorPropsDelegate {
    var presenter: SavedPresenterDelegate?
    var router: SavedRouterDelegate?
    var realmWorker: RealmWorkerSpecialDelegate?
}

extension SavedInteractor: SavedInteractorActionsDelegate {
    func getAllModels() {
        realmWorker?.getAllModels(completion: { result in
            switch result {
                
            case .success(let models):
                presenter?.updateModel(models)
            case .failure(let error):
                router?.showAlert(error.localizedDescription)
            }
        })
    }
}
