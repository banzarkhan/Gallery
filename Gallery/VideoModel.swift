//
//  VideoModel.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 16/08/24.
//

import Foundation

struct VideosResponse: Decodable {
    let response: VideosResponseData
}

struct VideosResponseData: Decodable {
    let items: [Video]
}

struct Video: Decodable, Hashable, Identifiable {
    let id: Int
    let title: String
    let player: String
    let image: [VideoImage]
}

struct VideoImage: Decodable, Hashable {
    let url: String
    let width: Int
    let height: Int
}
