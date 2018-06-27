//
//  VacancyListVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class VacancyListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var vacancyArray = [Vacancy]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //
    //  LIFECYCLE
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = InMemoryRequest(filter: "iOS", field: "title")
        request.execute {
            (result) in
            
            DispatchQueue.main.async {
                switch(result) {
                case let .success(resultArray):
                    self.vacancyArray = resultArray
                case let .error(error):
                    print("Error: \(error)")
                }
            }
            
        }
    }
    
    //
    //  DataSource protocol
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacancyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeuing reusable cell view
        let cell: VacancyCell = tableView.dequeueReusableCell(withIdentifier: "StandardCell", for: indexPath) as! VacancyCell
        
        // getting necessary item
        let item = vacancyArray[indexPath.row]
        
        // populating the cell with data from the item
        cell.titleLabel?.text = item.title
        cell.descriptionLabel?.text = item.description
        
        return cell
    }
    
    //
    // LOGIC
    //
}
