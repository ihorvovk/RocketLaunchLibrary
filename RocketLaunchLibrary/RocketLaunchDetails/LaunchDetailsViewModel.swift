//
//  LaunchDetailsViewModel.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 26.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LaunchDetailsViewModel {
    
    var infoURL: Driver<URL?> {
        infoURLRelay.asDriver()
    }
    
    func didLoad() {
        launchLibraryManager.loadRocketLaunchDetails(id: launch.id).subscribe(onNext: { [unowned self] launch in
            if let wikiURLString = launch.rocket?.wikiURL {
                self.infoURLRelay.accept(URL(string: wikiURLString))
            }
        }, onError: { error in
        }).disposed(by: disposeBag)
    }
    
    init(launch: RocketLaunch, launchLibraryManager: LaunchLibraryManager) {
        self.launch = launch
        self.launchLibraryManager = launchLibraryManager
    }
    
    // MARK: - Implementation
    
    private let launch: RocketLaunch
    private let launchLibraryManager: LaunchLibraryManager
    
    private var infoURLRelay = BehaviorRelay<URL?>(value: nil)
    private let disposeBag = DisposeBag()
}
