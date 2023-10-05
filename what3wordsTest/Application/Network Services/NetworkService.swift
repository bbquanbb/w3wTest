//
//  NetworkService.swift
//  what3wordsTest
//
//  Created by Quan on 04/10/2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case fromAFError(AFError)
    case noConnection
}


class NetworkService {
    
    func request<T: Decodable>(
        urlPath: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard NetworkReachabilityManager()!.isReachable else {
            completion(.failure(NetworkError.noConnection))
            return
        }
        
        var requestHeaders: HTTPHeaders = [
            "Authorization": "Bearer \(Endpoint.apiKey)"
        ]
        
        if let headers = headers {
            headers.forEach { header in
                requestHeaders.add(header)
            }
        }
        
        AF.request(urlPath, method: method, parameters: parameters, encoding: encoding, headers: requestHeaders)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: data),
                       let decodedObject = try? JSONDecoder().decode(T.self, from: jsonData) {
                        completion(.success(decodedObject))
                    } else {
                        completion(.failure(NetworkError.invalidResponse))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
