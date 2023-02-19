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
    var detailList = [DetailsModel]()
    var selectedServiceID: Int?
    
    func fetchMainModel(completion: @escaping(Result<MainModel, Error>) -> Void) {
        webservice.fetch(response: MainModel.self, with: .getHome, completion: { result in
            switch result {
            case .success(let response):
                if let employment = response.all_services {
                    self.serviceList = employment
                }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    func fetchServiceModel(completion: @escaping(Result<[DetailsModel], Error>) -> Void) {
        guard let serviceID = selectedServiceID else {
            completion(.failure(NSError(domain: "Service ID is nil", code: 0, userInfo: nil)))
            return
        }
        let endpoint = LimonAPICall.getService(serviceID: serviceID)
        webservice.fetch(response: [DetailsModel].self, with: endpoint, completion: { result in
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
