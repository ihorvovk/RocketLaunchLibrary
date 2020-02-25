//
//  LaunchListViewController.swift
//  RocketLaunchLibrary
//
//  Created by Ihor on 24.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit

class LaunchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        LaunchLibraryManager.shared.loadRocketLaunches(success: { [weak self] launches in
            guard let `self` = self else { return }
            
            self.rocketLaunches = launches
            self.tableView.reloadData()
        }) { error in
            print(error.localizedDescription)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Implementation
    
    @IBOutlet weak var tableView: UITableView!
    
    private var rocketLaunches: [RocketLaunch]?
}

extension LaunchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rocketLaunches?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rocketLaunch", for: indexPath) as! LaunchTableViewCell
        cell.fill(launch: rocketLaunches![indexPath.row])
        
        return cell
    }
}
