//
//  SortPresenter.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 27.08.2023.
//

import Foundation

protocol SortPresenterDelegate: AnyObject {
    var view: SortViewDelegate? { get set }
}

final class SortPresenter: SortPresenterDelegate {
    weak var view: SortViewDelegate?
}
