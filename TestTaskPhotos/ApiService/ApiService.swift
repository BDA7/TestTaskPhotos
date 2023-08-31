//
//  ApiService.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import Foundation

protocol MainViewServiceDelegate: AnyObject {
    func fetchDataMain(completion: @escaping (Result<[PictureModel], Error>) -> Void)
}

final class ApiService {
    private var session = URLSession.shared
    
    enum ApiServiceError: Error {
        case invalidURL
        case missingData
    }
}

extension ApiService: MainViewServiceDelegate {
    func fetchDataMain(completion: @escaping (Result<[PictureModel], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {
            completion(.failure(ApiServiceError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.configure(.get)
        
        session.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(ApiServiceError.missingData))
                return
            }
            
            do {
                let pictures = try JSONDecoder().decode([PictureModel].self, from: data)
                completion(.success(pictures))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}

extension URLRequest {
    mutating func configure(_ method: HttpMethod) {
        self.httpMethod = method.rawValue
    }
}

enum HttpMethod: String {
    case get = "GET"
}
