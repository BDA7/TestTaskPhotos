//
//  SortRouter.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 27.08.2023.
//

import UIKit

protocol SortRouterDelegate: AnyObject {
    var sortView: UIViewController? { get set }
    func pop()
    func showAlert(_ message: String?)
}

final class SortRouter: SortRouterDelegate {
    weak var sortView: UIViewController?
}

extension SortRouter {
    func pop() {
        sortView?.navigationController?.popToRootViewController(animated: true)
    }
    
    func showAlert(_ message: String?) {
        let alertView = AlertView(message)
        sortView?.present(alertView, animated: true)
    }
}
