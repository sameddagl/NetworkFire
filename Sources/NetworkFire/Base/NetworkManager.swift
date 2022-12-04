//
//  NetworkManager.swift
//  
//
//  Created by Samed Dağlı on 4.12.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Codable>(endpoint: HTTPEndpoint, completion: @escaping(Result<T, NetworkError>) -> Void)
}

public class NetworkManager {
    public func fetch<T: Codable>(endpoint: HTTPEndpoint, completion: @escaping(Result<T, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.host
        components.path = endpoint.path
        
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidURL))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                let decoder                  = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                }
                catch {
                    completion(.failure(.decode))
                }
            case 401:
                completion(.failure(.unauthorized))
            default:
                completion(.failure(.unexpectedStatusCode))
            }
        }
        
    }
}
