//
//  MainPresenter.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    var view: MainViewDelegate? { get set }
    
    func loadPictures(pictires: [PictureModel])
}

final class MainPresenter: MainPresenterDelegate {
    weak var view: MainViewDelegate?
}

extension MainPresenter {
    func loadPictures(pictires: [PictureModel]) {
        view?.updateViewModel(pictires)
    }
}
