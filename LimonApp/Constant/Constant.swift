//
//  Constant.swift
//  LimonApp
//
//  Created by Turan Çabuk on 11.02.2023.
//

import Foundation

enum LimonAPICall {
    private static let baseURL = "https://my-json-server.typicode.com/engincancan/case"
    
    case getHome
    case getService(serviceID: Int) // getService case'i artık bir associated value olan serviceID alıyor.
    
    var urlString: String {
        switch self {
        case .getHome:
            return "\(LimonAPICall.baseURL)/home"
        case .getService(let serviceID): // getService case'i için endpoint'e serviceID'yi ekleyin.
            return "\(LimonAPICall.baseURL)/service/\(serviceID)"
        }
    }
    
    var url: URL {
        return URL(string: urlString)!
    }
}

