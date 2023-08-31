//
//  TabBarViewController.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 28.08.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private let mainView = MainModule.build()
    private let savedView = SavedModule.build()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        viewControllers = [
            createNavControllers(for: mainView, title: "Главная",
                                 image: UIImage(systemName: "house")!,
                                 selectImage: UIImage(systemName: "house.fill")!
                                ),
            createNavControllers(for: savedView, title: "Сохраненные",
                                 image: UIImage(systemName: "star")!,
                                 selectImage: UIImage(systemName: "star.fill")!)
        ]
    }
    
    private func createNavControllers(for rootViewController: UIViewController,
        title: String, image: UIImage, selectImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectImage
        return navController
    }
}
