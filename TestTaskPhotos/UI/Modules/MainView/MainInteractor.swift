//
//  MainInteractor.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import UIKit

protocol MainInteractorPropsDelegate: AnyObject {
    var presenter: MainPresenterDelegate? { get set }
    var apiService: MainViewServiceDelegate? { get set }
    var router: MainRouterDelegate? { get set }
    var dataWorker: DataStoreWorkerDelegate? { set get }
    var realmWorker: RealmWorkerDelegate? { get set }
}

protocol InteractorNetworkDataDelegate: AnyObject {
    func getPictires()
    func loadActualData()
}

protocol InteractorMainRouteDelegate: AnyObject {
    func routeToSortView()
    func routeToFullView(_ url: String)
}

protocol InteractorCellDelegate: AnyObject {
    func addModelToRealm(model: PrictureModelProtocol)
    func findCell(_ model: PrictureModelProtocol, completion: (Bool) -> Void)
    func deleteModel(_ model: PrictureModelProtocol)
}

final class MainInteractor: MainInteractorPropsDelegate {
    var presenter: MainPresenterDelegate?
    var apiService: MainViewServiceDelegate?
    var router: MainRouterDelegate?
    var dataWorker: DataStoreWorkerDelegate?
    var realmWorker: RealmWorkerDelegate?
}

// MARK: - MainInteractor netModel
extension MainInteractor: InteractorNetworkDataDelegate {
    func getPictires() {
        apiService?.fetchDataMain(completion: { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.dataWorker?.setData(pictures)
                self?.loadActualData()
            case .failure(let failure):
                self?.router?.showAlert(failure.localizedDescription)
            }
        })
    }
    
    func loadActualData() {
        guard let pictures = dataWorker?.getData() else { return }
        presenter?.loadPictures(pictires: pictures)
    }
}

// MARK: - MainInteractor CellDelegate
extension MainInteractor: InteractorCellDelegate {
    func addModelToRealm(model: PrictureModelProtocol) {
        realmWorker?.addModel(model)
    }
    
    func findCell(_ model: PrictureModelProtocol, completion: (Bool) -> Void) {
        realmWorker?.findCell(model, completion: { result in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let failure):
                router?.showAlert(failure.localizedDescription)
            }
        })
    }
    
    func deleteModel(_ model: PrictureModelProtocol) {
        realmWorker?.removeCell(model)
    }
}

// MARK: MainInteractor Routing
extension MainInteractor: InteractorMainRouteDelegate {
    func routeToSortView() {
        router?.routeToSortView()
    }
    
    func routeToFullView(_ url: String) {
        router?.routeToFullView(url)
    }
}
