//
//  PictureModel.swift
//  TestTaskPhotos
//
//  Created by Данила Бондаренко on 26.08.2023.
//

import Foundation

protocol PrictureModelProtocol {
    var title: String { get set }
    var url: String { get set }
}

struct PictureModel: Codable, PrictureModelProtocol {
    public var albumId: Int
    public var id: Int
    public var title: String
    public var url: String
    public var thumbnailUrl: String
}
