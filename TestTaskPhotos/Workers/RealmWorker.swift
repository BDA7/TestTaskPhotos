//
//  RealmWorker.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 30.08.2023.
//

import Foundation
import RealmSwift

protocol RealmWorkerDelegate: AnyObject {
    func addModel(_ model: PrictureModelProtocol)
    func findCell(_ model: PrictureModelProtocol, completion: (Result<Bool, Error>) -> Void)
    func removeCell(_ model: PrictureModelProtocol)
}

protocol RealmWorkerSpecialDelegate: AnyObject {
    func getAllModels(completion: (Result<[PrictureModelProtocol], Error>) -> Void)
}

// MARK: - All delegates Methods
final class RealmWorker: RealmWorkerDelegate {
    
    func addModel(_ model: PrictureModelProtocol) {
         guard let realmModel = adapter(model: model) else { return }
        
        do {
            let realm = try Realm()
            try realm.write({
                realm.add(realmModel)
            })
        } catch {
            print(error)
        }
    }
    
    func findCell(_ model: PrictureModelProtocol, completion: (Result<Bool, Error>) -> Void) {
        do {
            let realm = try Realm()
            let models = realm.objects(AdapterModel.self).filter("title = '\(model.title)'")
            if models.count > 0 {
                completion(.success(true))
            } else {
                completion(.success(false))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func removeCell(_ model: PrictureModelProtocol) {
        do {
            let realm = try Realm()
            let deleteModel = realm.objects(AdapterModel.self).filter("title = '\(model.title)'")
            
            try realm.write {
                realm.delete(deleteModel)
            }
        } catch {
            print(error)
        }
    }
}

// MARK: - Private Methods
extension RealmWorker {
    private func adapter(model: PrictureModelProtocol) -> AdapterModel? {
        let realmModel = AdapterModel()
        realmModel._id = maxId() + 1
        realmModel.title = model.title
        realmModel.url = model.url
        
        return realmModel
    }
    
    private func maxId() -> Int {
        do {
            let realm = try Realm()
            let currentMax = realm.objects(AdapterModel.self).map{$0._id}.max()
            return currentMax ?? 0
        } catch {
            print(error)
        }
        
        return 0
    }
    
    private func convertToArray(realmModels: Results<AdapterModel>) -> [PrictureModelProtocol] {
        var models: [PrictureModelProtocol] = []
        for model in realmModels {
            models.append(model)
        }
        
        return models
    }
}

// MARK: Special delegates Methods
extension RealmWorker: RealmWorkerSpecialDelegate {
    func getAllModels(completion: (Result<[PrictureModelProtocol], Error>) -> Void) {
        do {
            let realm = try Realm()
            let realmModels = realm.objects(AdapterModel.self)
            let models = convertToArray(realmModels: realmModels)
            completion(.success(models))
        } catch {
            completion(.failure(error))
        }
    }
}

final class AdapterModel: Object, PrictureModelProtocol {
    @Persisted(primaryKey: true) var _id: Int
    @Persisted var title: String
    @Persisted var url: String
}
