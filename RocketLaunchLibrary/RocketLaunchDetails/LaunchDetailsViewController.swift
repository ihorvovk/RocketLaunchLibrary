//
//  LaunchDetailsViewController.swift
//  RocketLaunchLibrary
//
//  Created by Ihor Vovk on 26.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

class LaunchDetailsViewController: UIViewController {

    var viewModel: LaunchDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.infoURL.asObservable().subscribe(onNext: { url in
            guard let url = url else { return }
            let request = URLRequest(url: url)
            self.webView.load(request)
        }).disposed(by: disposeBag)
        
        viewModel.didLoad()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet private weak var webView: WKWebView!
    
    private let disposeBag = DisposeBag()
}
