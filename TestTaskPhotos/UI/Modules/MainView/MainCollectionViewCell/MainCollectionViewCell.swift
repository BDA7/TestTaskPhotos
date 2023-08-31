//
//  MainCollectionViewCell.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class MainCollectionViewCell: UICollectionViewCell {
    private var container = UIView()
    private let imageCell = UIImageView()
    private let nameCell = UILabel()
    private let specialButton = UIButton()
    
    var delegate: InteractorCellDelegate?
    
    private var viewModel: PrictureModelProtocol? {
        didSet {
            updateUI()
        }
    }
    
    private var isSpecial: Bool? {
        didSet {
            setCurrentImageButton()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Methods
extension MainCollectionViewCell {
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
        
        container.addSubview(nameCell)
        
        nameCell.snp.makeConstraints {
            $0.top.equalTo(imageCell.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        nameCell.font = .systemFont(ofSize: 12)
        nameCell.textColor = .white
        nameCell.numberOfLines = 0
        
        specialButton.addTarget(self, action: #selector(addModel), for: .touchUpInside)
        specialButton.setImage(UIImage(systemName: "star"), for: .normal)
        specialButton.tintColor = .yellow
        container.addSubview(specialButton)
        specialButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.trailing.equalToSuperview().offset(-4)
            $0.width.height.equalTo(40)
        }
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else { return }
        
        nameCell.text = viewModel.title

        imageCell.kf.indicatorType = .activity
        imageCell.kf.setImage(with: URL(string: viewModel.url), placeholder: UIImage(named: ""), options: [.cacheOriginalImage])
        
        getIsSpecial()
    }
    
    private func setCurrentImageButton() {
        guard let isSpecial = isSpecial else { return }
        
        UIView.transition(with: specialButton, duration: 0.5, options: .transitionCrossDissolve) {
            if isSpecial {
                self.specialButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                self.specialButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
}

// MARK: - Model Methods
extension MainCollectionViewCell {
    public func updateViewModel(viewModel: PrictureModelProtocol) {
        self.viewModel = viewModel
    }
    
    @objc private func addModel(_ sender: UIButton) {
        guard let viewModel = viewModel, let isSpecial = isSpecial else { return }
        if isSpecial {
            delegate?.deleteModel(viewModel)
        } else {
            delegate?.addModelToRealm(model: viewModel)
        }
        
        getIsSpecial()
    }
    
    private func getIsSpecial() {
        guard let viewModel = viewModel else { return }
        delegate?.findCell(viewModel, completion: { isSpectial in
            self.isSpecial = isSpectial
        })
    }
}
