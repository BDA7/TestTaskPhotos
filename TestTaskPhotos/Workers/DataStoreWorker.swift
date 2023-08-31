//
//  DataStoreWorker.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 27.08.2023.
//

import Foundation

protocol DataStoreWorkerDelegate {
    func getData() -> [PictureModel]
    func setData(_ newData: [PictureModel])
}

protocol DataStoreWorkerFilterDelegate {
    func setFilteredData(_ newData: [PictureModel])
    func getData() -> [PictureModel]
    func rejectFilters()
}

final class DataStoreWorker {
    private var data: [PictureModel] = []
    private var filteredData: [PictureModel] = []
    private var isFiltersUse: Bool = false
}

// MARK: - DataStoreWorker for all Methods
extension DataStoreWorker: DataStoreWorkerDelegate {
    func getData() -> [PictureModel] {
        return isFiltersUse ? filteredData : data
    }
    
    func setData(_ newData: [PictureModel]) {
        data = newData
    }
}

// MARK: - DataStoreWorker for Filter Methods
extension DataStoreWorker: DataStoreWorkerFilterDelegate {
    func setFilteredData(_ newData: [PictureModel]) {
        isFiltersUse = true
        filteredData = newData
    }
    
    func rejectFilters() {
        isFiltersUse = false
        filteredData = []
    }
}
