//
//  HTTPEndpoint.swift
//  
//
//  Created by Samed Dağlı on 4.12.2022.
//

import Foundation

public protocol HTTPEndpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var params: [URLQueryItem] { get }
    var method: HTTPMethod { get }
}

extension HTTPEndpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return Constants.baseURL
    }
    
    var method: HTTPMethod {
        return .get
    }
}
