//
//  ArticlesRemoteRepository.swift
//  NYTimes
//
//  Created by Shahbaz Khan on 10.10.21.
//

import UIKit
import Combine
protocol ItemsRemoteRepositoryProtocol {
    func fetchItems() -> AnyPublisher<ShoppingResponse, NetworkError>
}

final class ItemsRemoteRepository : ItemsRemoteRepositoryProtocol {
    
    var subscriptions: Set<AnyCancellable> = []
    private var serviceApi:ServiceApi
    
    init(
        service : ServiceApi
    ) {
        self.serviceApi = service
    }
    
    func fetchItems() -> AnyPublisher<ShoppingResponse, NetworkError> {
        let serviceURL = baseURL + "5c138271-d8dd-4112-8fb4-3adb1b7f689e"
        let request = URLRequest(
            url: URL.init(
                string: serviceURL
            )!
        )
        return serviceApi.getDataFromServer(
            request
        ).map(\.value).eraseToAnyPublisher()
    }
}
