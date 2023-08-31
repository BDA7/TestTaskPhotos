//
//  MainModule.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import Foundation

final class MainModule {
    static func build() -> MainViewController {
        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let service = ApiService()
        let router = MainRouter()
        let storeWorker = DataStoreWorker()
        let sortView = SortModule.build(dataWorker: storeWorker)
        let realmWorker = RealmWorker()
        
        interactor.presenter = presenter
        interactor.apiService = service
        interactor.router = router
        interactor.dataWorker = storeWorker
        interactor.realmWorker = realmWorker
        presenter.view = view
        view.interactor = interactor
        router.mainView = view
        router.sortView = sortView

        return view
    }
}
