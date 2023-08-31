//
//  SavedPresenter.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 30.08.2023.
//

import Foundation

protocol SavedPresenterDelegate: AnyObject {
    var view: SavedViewDelegate? { get set }
    
    func updateModel(_ model: [PrictureModelProtocol])
}

final class SavedPresenter: SavedPresenterDelegate {
    var view: SavedViewDelegate?
}

extension SavedPresenter {
    func updateModel(_ model: [PrictureModelProtocol]) {
        view?.updateModel(model)
    }
}
