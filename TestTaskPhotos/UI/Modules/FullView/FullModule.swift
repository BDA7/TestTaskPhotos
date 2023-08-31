//
//  FullModule.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 31.08.2023.
//

import UIKit

final class FullModule {
    static func build(_ url: String) -> FullViewController {
        let view = FullViewController()
        view.setURL(url)
        
        return view
    }
}
