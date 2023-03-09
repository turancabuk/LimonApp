//
//  MainWebservice.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import Foundation

/// This creates the protocol that the fetch function will execute in the MainWebservice.
protocol MainWebserviceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: LimonAPICall, completion: @escaping(Result <T, Error>) -> Void)
}
/// This is the class that calls the API with the required case from the Constant structure that implements the MainWebserviceProtocol.
final class MainWebservice: MainWebserviceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: LimonAPICall, completion: @escaping(Result <T, Error>) -> Void) {
        let urlRequest = URLRequest(url: path.url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFound))
                return
            }
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            }catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
enum NetworkError: Error {
    case dataNotFound
}

