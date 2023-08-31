//
//  ViewController.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 31.08.2023.
//

import UIKit

protocol ViewPresentable {
    func createUI()
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let presentable = self as? ViewPresentable {
            presentable.createUI()
        }
    }
}
