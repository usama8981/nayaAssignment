//
//  WebAPIHandler.swift
//  NayaAssignment
//
//  Created by Usama Ali on 02/04/2022.
//

import Combine
import Foundation

struct Response<T> {
        let value: T
     }

protocol WebAPIHandler {
    func getDataFromServer<T: Decodable>(_ request: URLRequest)-> AnyPublisher<Response<T>, NetworkError>
}
