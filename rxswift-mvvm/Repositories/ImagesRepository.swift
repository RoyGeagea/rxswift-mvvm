//
//  ImagesRepository.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 8/1/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift

protocol ImagesRepositoryInterface {
    func getImages(key: String) -> Observable<ImageResults>
}

class ImagesRemoteRepository: ImagesRepositoryInterface {

    private let repository: NetworkingRepository<ImageResults, ImagesAPI>

    init(networkManeger: NetworkManager) {
        self.repository = NetworkingRepository<ImageResults, ImagesAPI>(networkManager: networkManeger)
    }
}

extension ImagesRemoteRepository {
    func getImages(key: String) -> Observable<ImageResults> {
        self.repository.get(query: ImagesAPI.getImages(key: key), sortDescriptors: nil)
    }
}


