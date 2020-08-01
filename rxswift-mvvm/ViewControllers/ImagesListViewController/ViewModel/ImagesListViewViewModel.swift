//
//  ImagesListViewViewModel.swift
//  rxswift-mvvm
//
//  Created by Roy Geagea on 7/31/20.
//  Copyright © 2020 Roy Geagea. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ImagesListViewViewModel {
    
    private let _images = BehaviorRelay<[Image]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    private let imagesRepository: ImagesRepositoryInterface
    private let userRepository: UserRepositoryInterface
    private let disposeBag = DisposeBag()
    
    init(imagesRepository: ImagesRepositoryInterface, userRepository: UserRepositoryInterface) {
        self.imagesRepository = imagesRepository
        self.userRepository = userRepository
    }
    
    func fetchImages() {
        self._images.accept([])
        self._isFetching.accept(true)
        self._error.accept(nil)
        
        self.userRepository.getCurrentUser()
            .flatMap {self.imagesRepository.getImages(key: $0.token ?? "" )}
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { [weak self] response in
                    self?._isFetching.accept(false)
                    self?._images.accept(response.hits ?? [Image]())
                },
                onError: { error in
                    self._isFetching.accept(false)
                    self._error.accept(error.localizedDescription)
            }).disposed(by: self.disposeBag)
    }
    
    func viewModelForImage(index: Int) -> ImageViewViewModel {
        return ImageViewViewModel(image: _images.value[index])
    }
}

extension ImagesListViewViewModel {
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var images: Driver<[Image]> {
        return _images.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfImages: Int {
        return _images.value.count
    }
}
