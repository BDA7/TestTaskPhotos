//
//  SavedViewController.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 30.08.2023.
//

import UIKit

protocol SavedViewDelegate: AnyObject {
    var interactor: SavedInteractorActionsDelegate? { get set }
    
    func updateModel(_ newModel: [PrictureModelProtocol])
}

final class SavedViewController: UIViewController {
    private var collectionView: UICollectionView?
    
    var interactor: SavedInteractorActionsDelegate?
    
    private var savedPictures: [PrictureModelProtocol] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.getAllModels()
    }
}

extension SavedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: setupCollectionLayout())
        
        guard let collectionView = collectionView else { return }
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SavedCollectionViewCell.self, forCellWithReuseIdentifier: "savedCell")
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
        return savedPictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedCell", for: indexPath) as! SavedCollectionViewCell
        let cellViewModel = savedPictures[indexPath.row]
        cell.updateViewModel(cellViewModel)
        
        return cell
    }
    
    
}

// MARK: - Delegate Methods
extension SavedViewController: SavedViewDelegate {
    func updateModel(_ newModel: [PrictureModelProtocol]) {
        savedPictures = newModel
        collectionView?.reloadData()
    }
}
