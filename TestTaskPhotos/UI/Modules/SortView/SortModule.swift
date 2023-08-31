//
//  SortModule.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import Foundation

final class SortModule {
    static func build(dataWorker: DataStoreWorkerFilterDelegate) -> SortViewController {
        let view = SortViewController()
        let presenter = SortPresenter()
        let interactor = SortInteractor()
        let router = SortRouter()
        
        interactor.presenter = presenter
        interactor.dataWorker = dataWorker
        interactor.router = router
        presenter.view = view
        router.sortView = view
        view.interactor = interactor
        
        return view
    }
}
