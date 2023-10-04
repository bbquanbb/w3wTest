//
//  NetworkService.swift
//  what3wordsTest
//
//  Created by Quan on 04/10/2023.
//

import Foundation
import Alamofire

class NetworkService {
    static let shared = NetworkService()
        
    private init() {}
    
    func request<T: Decodable>(
        urlPath: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let fullUrl = baseUrl + urlPath
        
        var requestHeaders: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        
        // Merge additional headers if provided
        if let headers = headers {
            requestHeaders.merge(headers) { (_, new) in new }
        }
        
        AF.request(fullUrl, method: method, parameters: parameters, encoding: encoding, headers: requestHeaders)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
