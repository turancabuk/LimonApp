//
//  MainViewModel.swift
//  LimonApp
//
//  Created by Turan Çabuk on 11.02.2023.
//

import Foundation

final class MainViewModel {
    
    private let webservice: MainWebserviceProtocol
    
    init(webservice: MainWebserviceProtocol) {
        self.webservice = webservice
    }
    
    var mainModel = MainModel(all_services: [], popular: [], posts: [])
    var serviceList = [Service]()
    var popularList = [Popular]()
    var postList = [Post]()
    var detailList = [ServiceDetailsModel]()
    var selectedServiceID: Int?
    
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
    func fetchServiceModel(completion: @escaping(Result<[ServiceDetailsModel], Error>) -> Void) {
        guard let serviceID = selectedServiceID else {
            completion(.failure(NSError(domain: "Service ID is nil", code: 0, userInfo: nil)))
            return
        }
        let endpoint = LimonAPICall.getService(serviceID: serviceID)
        webservice.fetch(response: [ServiceDetailsModel].self, with: endpoint, completion: { result in
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
