//
//  Constant.swift
//  LimonApp
//
//  Created by Turan Çabuk on 11.02.2023.
//

import Foundation

enum LimonAPICall: String {
    
    private var baseURL: String {
        "https://my-json-server.typicode.com/engincancan/case"
    }
    private var homeURL: String {
        "/home"
    }
    private var serviceURL: String {
        "/service"
    }
    
case getHome
case getService
    
    var urlString: String {
        switch self {
        case .getHome:
            return "\(baseURL)\(homeURL)"
        case .getService:
            return "\(baseURL)\(serviceURL)"
        }
    }
    var url: URL {
        return URL(string: urlString)!
        
    }
}
