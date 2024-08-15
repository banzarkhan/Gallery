//
//  PhotoModel.swift
//  Gallery
//
//  Created by Ariuna Banzarkhanova on 16/08/24.
//

import Foundation

struct PhotosResponse: Decodable,Hashable{
    let response: Response
}

struct Response: Decodable,Hashable {
    let items: [Photo]
}

struct Photo: Decodable,Hashable,Identifiable {
    let id: Int
    let sizes: [Size]
    let date: Int
}

struct Size: Decodable, Hashable {
    let url: String
}
