//
//  SavedModule.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 30.08.2023.
//

import Foundation

final class SavedModule {
    static func build() -> SavedViewController {
        let view = SavedViewController()
        let presenter = SavedPresenter()
        let interactor = SavedInteractor()
        let router = SavedRouter()
        let realmWorker = RealmWorker()
        
        presenter.view = view
        interactor.presenter = presenter
        interactor.router = router
        interactor.realmWorker = realmWorker
        router.sortView = view
        view.interactor = interactor
        
        return view
    }
}
