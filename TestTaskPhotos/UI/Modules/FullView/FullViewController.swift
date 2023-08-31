//
//  FullViewController.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 31.08.2023.
//

import UIKit
import Kingfisher

final class FullViewController: UIViewController {
    private let mainImage = UIImageView()
    private var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        uploadImage()
    }
    
    private func createUI() {
        mainImage.contentMode = .scaleAspectFill
        view.addSubview(mainImage)
        mainImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalTo(view.snp.centerY)
        }
    }
    
    private func uploadImage() {
        mainImage.kf.indicatorType = .activity
        mainImage.kf.setImage(with: URL(string: url), placeholder: UIImage(named: ""), options: [.cacheOriginalImage])
    }
    
    public func setURL(_ url: String) {
        self.url = url
    }
}
