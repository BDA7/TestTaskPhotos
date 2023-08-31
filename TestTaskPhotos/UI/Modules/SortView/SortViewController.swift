//
//  SortViewController.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import UIKit
import SnapKit

protocol SortViewDelegate: AnyObject {
    var interactor: SortInteractorActionsDelegate? { get set }
}

final class SortViewController: UIViewController {
    private var searchNameLabel = UILabel()
    private let searchTitleTextField = UITextField()
    private let idLabel = UILabel()
    private let minValTextField = UITextField()
    private let maxValTextField = UITextField()
    private let applyButton = UIButton()
    private let rejectButton = UIButton()
    
    var interactor: SortInteractorActionsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        searchNameLabel.text = "Поиск по названию"
        searchNameLabel.textColor = .white
        searchNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(searchNameLabel)
        searchNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalToSuperview()
        }
        
        searchTitleTextField.placeholder = "Название"
        searchTitleTextField.backgroundColor = .white
        searchTitleTextField.layer.cornerRadius = 10
        searchTitleTextField.layer.masksToBounds = true
        view.addSubview(searchTitleTextField)
        searchTitleTextField.snp.makeConstraints {
            $0.top.equalTo(searchNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(40)
        }
        
        idLabel.text = "Сортировка по id"
        idLabel.textColor = .white
        idLabel.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(idLabel)
        idLabel.snp.makeConstraints {
            $0.top.equalTo(searchTitleTextField.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        minValTextField.placeholder = "min"
        minValTextField.textAlignment = .center
        minValTextField.backgroundColor = .white
        minValTextField.layer.cornerRadius = 10
        minValTextField.layer.masksToBounds = true
        view.addSubview(minValTextField)
        minValTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.width.equalTo(view.bounds.width/3)
            $0.height.equalTo(40)
        }
        
        maxValTextField.placeholder = "max"
        maxValTextField.textAlignment = .center
        maxValTextField.backgroundColor = .white
        maxValTextField.layer.cornerRadius = 10
        maxValTextField.layer.masksToBounds = true
        view.addSubview(maxValTextField)
        maxValTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.width.equalTo(view.bounds.width/3)
            $0.height.equalTo(40)
        }
        
        setupButton()
        setupRejectButton()
    }
    
    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.title = "Применить фильтры"
        
        applyButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        applyButton.configuration = config
        view.addSubview(applyButton)
        applyButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(50)
        }
    }
    
    private func setupRejectButton() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.baseBackgroundColor = .red
        config.title = "Сбросить фильтры"
        
        rejectButton.addTarget(self, action: #selector(rejectFilters), for: .touchUpInside)
        rejectButton.configuration = config
        view.addSubview(rejectButton)
        rejectButton.snp.makeConstraints {
            $0.bottom.equalTo(applyButton.snp.top).offset(-8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(50)
        }
    }
    
    @objc private func filterAction(_ sender: UIButton) {
        interactor?.applyFilters(min: minValTextField.text, max: maxValTextField.text, title: searchTitleTextField.text)
    }
    
    @objc private func rejectFilters(_ sender: UIButton) {
        interactor?.rejectFilters()
        minValTextField.text = ""
        maxValTextField.text = ""
        searchTitleTextField.text = ""
    }
}

extension SortViewController: SortViewDelegate {}
