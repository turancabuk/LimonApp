//  MainViewModel.swift
//  LimonApp
//
//  Created by Turan Çabuk on 11.02.2023.
//

import Foundation

/// This is the class that calls MainModel and ServiceModel using the Network class as a generic and assigns the results returned from the Response to the relevant arrays for use in the ViewController.
final class MainViewModel {
    
    private let webservice: MainWebserviceProtocol
    
    init(webservice: MainWebserviceProtocol) {
        self.webservice = webservice
    }
    
    var mainModel = MainModel(all_services: [], popular: [], posts: [])
    var serviceList = [Service]()
    var popularList = [Popular]()
    var postList = [Post]()
    var detailList: ServiceDetailsModel?
    var searchResultArray: [Service] = []
    var serviceID: Int?
    
    func fetchMainModel(completion: @escaping(Result<MainModel, Error>) -> Void) {
        webservice.fetch(response: MainModel.self, with: .getHome, completion: { result in
            switch result {
            case .success(let response):
                self.serviceList = response.all_services ?? []
                self.popularList = response.popular
                self.postList = response.posts
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    func fetchServiceModel(serviceID: Int, completion: @escaping(Result<ServiceDetailsModel, Error>) -> Void) {
        let endpoint = LimonAPICall.getService(serviceID: serviceID)
        webservice.fetch(response: ServiceDetailsModel.self, with: endpoint, completion: { result in
            switch result {
            case .success(let response):
                self.detailList = response
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
