//
//  SavedRouter.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 31.08.2023.
//

import UIKit

protocol SavedRouterDelegate: AnyObject {
    var sortView: UIViewController? { get set }
    
    func showAlert(_ message: String?)
}

final class SavedRouter: SavedRouterDelegate {
    var sortView: UIViewController?
}

extension SavedRouter {
    func showAlert(_ message: String?) {
        let alertView = AlertView(message)
        sortView?.present(alertView, animated: true)
    }
}
