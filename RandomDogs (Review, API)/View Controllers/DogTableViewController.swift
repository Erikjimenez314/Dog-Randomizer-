//
//  DogTableViewController.swift
//  RandomDogs (Review, API)
//
//  Created by Erik Jimenez on 2/17/22.
//

import UIKit

class TopLevelObjectTableViewController: UITableViewController {
    
    // SOT
    
    var topLevelObjects: TopLevelObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TopLevelObjectController.fetchDogs { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let topLevelObjects):
                    self.topLevelObjects = topLevelObjects
                    self.tableView.reloadData()
                case.failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription)")
                    
                }
            }
        }
        
        // Usually in projects, (not related to the cell), functions need to be directly called in the view did load in order to work, sometimes it may not fetch or any other instance of a func because it is called outside of this.
        
        // Also and error to note is that the image of dogs gets distorted a bit when called, not sure why. might solve later.
        
        // Problem with distorting solved by putting equal widths and equal height.

        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func refreshDogButtonTap(_ sender: Any) {
        TopLevelObjectController.fetchDogs { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let topLevelObjects):
                    self.topLevelObjects = topLevelObjects
                    self.tableView.reloadData()
                case.failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription)")
                    
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topLevelObjectCell", for: indexPath) as? TopLevelObjectTableViewCell else {return UITableViewCell()}
        
        let topLevelObject = self.topLevelObjects
        cell.topLevelObject = topLevelObject
    
        return cell
    }
    

  

}
