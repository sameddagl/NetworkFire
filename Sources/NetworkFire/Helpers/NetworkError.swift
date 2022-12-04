//
//  NetworkError.swift
//  
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

public enum NetworkError: String, Error {
    case decode
    case invalidURL
    case noData
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}

