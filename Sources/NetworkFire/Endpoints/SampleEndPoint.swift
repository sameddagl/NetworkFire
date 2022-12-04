//
//  SampleEndPoint.swift
//  
//
//  Created by Samed Dağlı on 5.12.2022.
//

import Foundation

enum SampleEndPoint: HTTPEndpoint {
    case fetchNowPlaying(page: Int)
    
    //https://api.themoviedb.org/3/movie/now_playing?api_key=3628cca7b1f145241f88009eac10fc7c&language=en-US&page=1
    var path: String {
        switch self {
        case .fetchNowPlaying:
            return "now_playing"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .fetchNowPlaying(let page):
            return [
                URLQueryItem(name: "api_key", value: Constants.apiKey),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: String(page))
            ]
        }
    }    
}
