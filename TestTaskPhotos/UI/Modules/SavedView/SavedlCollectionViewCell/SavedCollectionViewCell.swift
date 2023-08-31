//
//  SavedCollectionViewCell.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 30.08.2023.
//

import UIKit
import Kingfisher

final class SavedCollectionViewCell: UICollectionViewCell {
    private let container = UIView()
    private let imageCell = UIImageView()
    private let titleCell = UILabel()
    
    private var viewModel: PrictureModelProtocol? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createUI() {
        addSubview(container)
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.white.cgColor
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        container.addSubview(imageCell)
        imageCell.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(self.bounds.height*2/3)
        }
        
        container.addSubview(titleCell)
        
        titleCell.snp.makeConstraints {
            $0.top.equalTo(imageCell.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        titleCell.font = .systemFont(ofSize: 12)
        titleCell.textColor = .white
        titleCell.numberOfLines = 0
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        
        titleCell.text = viewModel.title

        imageCell.kf.indicatorType = .activity
        imageCell.kf.setImage(with: URL(string: viewModel.url), placeholder: UIImage(named: ""), options: [.cacheOriginalImage])
    }
    
    public func updateViewModel(_ viewModel: PrictureModelProtocol) {
        self.viewModel = viewModel
    }
}
