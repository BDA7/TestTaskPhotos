//
//  MainRouter.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import UIKit

protocol MainRouterDelegate: AnyObject {
    var mainView: UIViewController? { get set }
    var sortView: UIViewController? { get set }
    
    func routeToSortView()
    func routeToFullView(_ url: String)
    func showAlert(_ message: String?)
}

final class MainRouter {
    weak var mainView: UIViewController?
    var sortView: UIViewController?
}

extension MainRouter: MainRouterDelegate {
    func routeToSortView() {
        guard let sortView = sortView else { return }
        sortView.hidesBottomBarWhenPushed = true
        mainView?.navigationController?.pushViewController(sortView, animated: true)
    }
    
    func routeToFullView(_ url: String) {
        let fullView = FullModule.build(url)
        fullView.hidesBottomBarWhenPushed = true
        mainView?.navigationController?.pushViewController(fullView, animated: true)
    }
    
    func showAlert(_ message: String?) {
        let alertView = AlertView(message)
        mainView?.present(alertView, animated: true)
    }
}

