//
//  Main Model.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//
import Foundation

import Foundation

struct MainModel: Codable {
    let all_services: [Service]
    let popular: [Popular]
    let posts: [Post]
    
    private enum CodingKeys: String, CodingKey {
        case all_services
        case popular
        case posts
    }
}
struct Service: Codable {
    let id: Int
    let service_id: Int
    let name: String
    let long_name: String
    let image_url: String?
    let pro_count: Int?
}
struct Popular: Codable {
    let id: Int
    let service_id: Int
    let name: String
    let long_name: String
    let image_url: String
    let pro_count: Int
}
struct Post: Codable {
    let link: String
    let title: String
    let category: String
    let image_url: String
}
