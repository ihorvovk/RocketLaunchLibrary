//
//  LaunchLibraryManager.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 2/17/20.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class LaunchLibraryManager {
    
    static let shared = LaunchLibraryManager()
    
    enum Error: Swift.Error {
        case notFound
    }
    
    func loadRocketLaunches(success: @escaping ([RocketLaunch]) -> Void, failure: @escaping (Swift.Error) -> Void) {
        let parameters: [String: Any] = ["mode": "list", "sort": "desc", "fields": "id,name", "limit": 1000000]
        let decoder = JSONDecoder()
        if let delegate = UIApplication.shared.delegate as? AppDelegate, let managedObjectContextKey = CodingUserInfoKey(rawValue: "managedObjectContext") {
            decoder.userInfo[managedObjectContextKey] = delegate.persistentContainer.viewContext
        }
        
        AF.request(apiURL, parameters: parameters).validate().responseDecodable(decoder: decoder, completionHandler: { (response: DataResponse<RocketLaunchList, AFError>) in
            switch response.result {
            case .success(let result):
                success(result.launchesArray)
            case .failure(let error):
                failure(error)
            }
        })
    }
    
    func loadRocketLaunchDetails(id: Int) -> Observable<RocketLaunch> {
        return Observable.create { observer -> Disposable in
            let parameters: [String: Any] = ["mode": "verbose", "id": "\(id)"]
            AF.request(self.apiURL, parameters: parameters).validate().responseDecodable(completionHandler: { (response: DataResponse<RocketLaunchList, AFError>) in
                switch response.result {
                case .success(let result):
                    if let launch = result.launchesArray.first {
                        observer.onNext(launch)
                        observer.onCompleted()
                    } else {
                        observer.onError(Error.notFound)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create()
        }
    }
    
    private let apiURL = "https://launchlibrary.net/1.4/launch"
}
