//
//  NetworkHelper.swift
//  Movie
//
//  Created by Asanali Zhansay on 07.02.2022.
//

import Foundation

// MARK: - Networking Error Types
enum ErrorType: LocalizedError {
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object"
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong"
        }
    }
}


// MARK: - HTTP Methods
enum HTTPMethod {
    case get
    case post
    case put
    case delete
    
    var value: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .delete: return "DELETE"
        }
    }
}
