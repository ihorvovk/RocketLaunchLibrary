//
//  LaunchListViewController.swift
//  RocketLaunchLibrary
//
//  Created by Ihor on 24.02.2020.
//  Copyright © 2020 Ihor Vovk. All rights reserved.
//

import UIKit
import CoreData

class LaunchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        var rocketLaunch = RocketLaunch(context: appDelegate.persistentContainer.viewContext)
//        rocketLaunch.id = 123
//        appDelegate.saveContext()
//
//        var fetchRequest: NSFetchRequest<RocketLaunch> = RocketLaunch.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id = 123")
//        rocketLaunch = try! appDelegate.persistentContainer.viewContext.fetch(fetchRequest).first as! RocketLaunch
//
//        rocketLaunch.name = "name"
//        appDelegate.saveContext()
         
        
        let fetchRequest: NSFetchRequest<RocketLaunch> = RocketLaunch.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        
        try? fetchResultsController.performFetch()
        updateLaunches()
        
        LaunchLibraryManager.shared.loadRocketLaunches(success: { [weak self] launches in
        }) { error in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "launchDetails", let launchDetailsVC = segue.destination as? LaunchDetailsViewController, let index = tableView.indexPathsForSelectedRows?.first?.row, let launch = rocketLaunches?[index] {
            
            let viewModel = LaunchDetailsViewModel(launch: launch, launchLibraryManager: LaunchLibraryManager.shared)
            launchDetailsVC.viewModel = viewModel
        }
    }

    // MARK: - Implementation
    
    private func updateLaunches() {
        rocketLaunches = fetchResultsController.fetchedObjects
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var rocketLaunches: [RocketLaunch]?
    private var fetchResultsController: NSFetchedResultsController<RocketLaunch>!
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

extension LaunchListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateLaunches()
    }
}
