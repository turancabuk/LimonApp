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
    var employmentList = [Service]()
    var serviceList = [DetailsModel]()
    var selectedServiceID: Int?
    
    func fetchMainModel(completion: @escaping(Result<MainModel, Error>) -> Void) {
        webservice.fetch(response: MainModel.self, with: .getHome, completion: { result in
            switch result {
            case .success(let response):
                if let employment = response.all_services {
                    self.employmentList = employment
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
        webservice.fetch(response: [DetailsModel].self, with: .getService, completion: { result in
            switch result {
            case .success(let response):
                self.serviceList = response
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
