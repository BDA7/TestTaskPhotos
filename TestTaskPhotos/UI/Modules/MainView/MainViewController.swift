//
//  MainViewController.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    var interactor: (InteractorMainRouteDelegate & InteractorNetworkDataDelegate)? { get set }
    
    func updateViewModel(_ pictures: [PictureModel])
    func loadCurrentData()
}

final class MainViewController: UIViewController {
    private var collectionView: UICollectionView?
    private var viewModel: [PictureModel] = []
    
    var interactor: (InteractorMainRouteDelegate & InteractorNetworkDataDelegate)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.getPictires()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadActualData()
    }
}

// MARK: - UI Methods
extension MainViewController {
    private func setupUI() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Фильтры", style: .done, target: self, action: #selector(routeToFilters))
        setupCollectionView()
    }
}

// MARK: - Delegate Methods
extension MainViewController: MainViewDelegate {
    func updateViewModel(_ pictures: [PictureModel]) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = pictures
            self?.collectionView?.reloadData()
        }
    }
    
    func loadCurrentData() {
        interactor?.loadActualData()
    }
}

// MARK: - CollectionView Methods
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: setupCollectionLayout())
        
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(collectionView)
    }
    
    private func setupCollectionLayout() -> UICollectionViewFlowLayout {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width/2 - 16, height: UIScreen.main.bounds.size.width/2 - 16)
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 8
        
        return layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        let cellViewModel = viewModel[indexPath.row]
        cell.delegate = interactor as? InteractorCellDelegate
        cell.updateViewModel(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectModel = viewModel[indexPath.row]
        interactor?.routeToFullView(selectModel.url)
    }
}

// MARK: - Action Methods
extension MainViewController {
    @objc private func routeToFilters(_ sender: UIButton) {
        interactor?.routeToSortView()
    }
}
