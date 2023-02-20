//
//  ServiceDetailsModel.swift
//  LimonApp
//
//  Created by Turan Çabuk on 13.02.2023.
//

import Foundation

struct ServiceDetailsModel: Codable{
    let id: Int?
    let service_id: Int?
    let name: String?
    let long_name: String?
    let image_url: String?
    let pro_count: Int?
    let average_rating: Float?
    let completed_jobs_on_last_month: Int?
    
}
