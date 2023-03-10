//
//  Constant.swift
//  LimonApp
//
//  Created by Turan Çabuk on 11.02.2023.
//

import Foundation
/// This is a class with enum structure and different cases for use in Network.
enum LimonAPICall {
    private static let baseURL = "https://my-json-server.typicode.com/engincancan/case"
    
    case getHome
    case getService(serviceID: Int)
    
    var urlString: String {
        switch self {
        case .getHome:
            return "\(LimonAPICall.baseURL)/home"
        case .getService(let serviceID): 
            return "\(LimonAPICall.baseURL)/service/\(serviceID)"
        }
    }
    var url: URL {
        return URL(string: urlString)!
    }
}

