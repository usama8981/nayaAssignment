//
//  NetworkError.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

enum NetworkError: Error {
    case noNetwork
    case parsingError(String)
    case unknown(String)
    case other(String)
}

extension NetworkError {
    
    var localizedDescription : String {
        
        switch self {
        case .noNetwork:
            return "Please check your internet connection"
        case .parsingError(let error):
            return error
        case .unknown(let error):
            return error
        case .other(let error):
            return error
        }
    }
}
