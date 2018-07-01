//
//  FavoritesVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 28.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit

class FavoritesVC: BaseSceenView, FavoritesViewProtocol, UITableViewDataSource, UITableViewDelegate {

    var presenter: FavoritesPresenter?
    var favoriteList = [Vacancy]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //
    //  BaseView
    //
    override func update() {
        if let fav = presenter?.favorites {
            favoriteList = fav
        }
    }
    
    //
    //  OUTLETS
    //
    @IBOutlet var tableView: UITableView!
    
    //
    //  View Commands
    //
    func updateCellWith(_ result: ImageResult, forRowAt index: IndexPath, and vacancy: Vacancy) {
        guard let logoIndex = favoriteList.index(of: vacancy),
            case let .success(image) = result else {
                return
        }
        let logoIndexPath = IndexPath(item: logoIndex, section: 0)
        
        // When the request finishes, only update the cell if it's still visible
        if let cell = tableView.cellForRow(at: logoIndexPath) as? FavoriteCell {
            cell.update(with: image)
        }
    }
    
    
    //
    // UITableViewDataSource protocol
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeuing reusable cell view
        let cell: FavoriteCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        
        // getting necessary item
        let item = favoriteList[indexPath.row]
        
        // populating the cell with data from the item
        cell.titleLabel?.text = item.title
        cell.descriptionLabel?.text = item.description
        
        return cell
    }
    
    //
    //  UITableViewDelegate
    //
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let vacancy = favoriteList[indexPath.row]
        let imageUrl = vacancy.employer.logoUrl
        
        // DOWNLOADING DATA
        presenter?.needImageForUrl(imageUrl!, forRowAt: indexPath, and: vacancy)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    //
    //  LIFECYCLE
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
        presenter = FrameworkFactory.presenterForFavorites()
        presenter?.attachView(self, updating: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getAllFavorites()
    }
    
    //
    //
    //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showVacancyDetailFromFavorites":
            if let row = tableView.indexPathForSelectedRow?.row {
                let vacancy = favoriteList[row]
                let detailVacancyVC = segue.destination as! DetailVacancyVC
                detailVacancyVC.vacancy = vacancy
            }
        default:
            print("No such a segue: \(String(describing: segue.identifier))")
        }
    }
}
