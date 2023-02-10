//
//  MainWebservice.swift
//  LimonApp
//
//  Created by Turan Çabuk on 10.02.2023.
//

import Foundation

protocol WebserviceProtocol {
    func fetch<T: Codable>(response: T.Type, with path: LimonAPICall, completion: @escaping(Result <T, Error>) -> Void)
}
final class LimonWebservice: WebserviceProtocol {
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
