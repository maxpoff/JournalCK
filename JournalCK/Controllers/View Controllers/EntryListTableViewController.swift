//
//  EntryListTableViewController.swift
//  JournalCK
//
//  Created by Maxwell Poffenbarger on 2/4/20.
//  Copyright © 2020 Maxwell Poffenbarger. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.sharedInstance.fetchEntries { (success) in
            if (success) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedInstance.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.sharedInstance.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatToString()
        
        return cell
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "toDetailVC" {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
         let destinationVC = segue.destination as? EntryDetailViewController
         let entry = EntryController.sharedInstance.entries[indexPath.row]
         destinationVC?.entry = entry
       }
     }
}//End of class
