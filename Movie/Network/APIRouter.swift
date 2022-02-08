//
//  APIRouter.swift
//  Movie
//
//  Created by Asanali Zhansay on 07.02.2022.
//

import Foundation

public typealias Parameters = [String: String]

enum APIRouter {
    case searchMovie(String)
    case details(Int)
    
    private static let baseURLString = "https://api.themoviedb.org/3"
    static let imageURLString = "https://image.tmdb.org/t/p/w154"
    
    // MARK: - Methods
    private var method: HTTPMethod {
        switch self {
        case .searchMovie, .details:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        case .details(let id):
            return "/movie/\(id)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters {
        switch self {
        case .searchMovie(let query):
            return ["query": query]
        default:
            return [:]
        }
    }
    
    private var apiKey: String {
        return "b10ebbfcf13f9485999cdf3bd0f1d053"
    }
    
    func request() throws -> URLRequest {
        let urlString = "\(APIRouter.baseURLString)\(path)"
        
        var components = URLComponents(string: urlString)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
    
        // add api key
        let apiItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems?.append(apiItem)
        
        guard let url = components.url else {
            throw ErrorType.parseUrlFail
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}
