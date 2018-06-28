//
//  VacancyListVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit


class VacancyListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, VacancyListViewProtocol{
    
    //
    //  Observer
    //
    func update() {
        if let unWrappedArray = presenter?.vacancyArray {
            self.vacancyArray = unWrappedArray
        }
    }
    
    //
    //  Commands
    //
    ///
    func showVacancyDetailFor(vacancy: Vacancy) {
        // TODO: segue to detail view
        print("\(#function): TBD")
    }
    ///
    func showErrorAlert(title:String, message:String) {
        // TODO: showing alert with messages
        print("\(#function): TBD")
    }
    
    var searchText: String {
        get {
            return searchBar.text!
        }
    }
    
    // Controls the view
    var presenter: VacancyListPresenter?
    
    //
    //  OUTLETS
    //
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    /// Data to be shown in the table view
    var vacancyArray = [Vacancy]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    /// Height of the parent TabbarVC's tab bar
    var tabBarHeight: CGFloat {
        get {
            return (tabBarController?.tabBar.frame.size.height)!
        }
    }
    
    //
    //  LIFECYCLE
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Subscribe?
        
        // listening for keyboard events
        // to know when it appear in the screen and goes away
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: Update data?
        // attaching
        presenter?.attachView(self, updating: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter?.detachView(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    /// Reacts to keyboard view changes
    /// to shift the view and avoid overlapping
    @objc func keyBoardWillChange(notification: Notification){
        
        // getting keyboard's height
        guard let keyboardRect = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        // shifting the view up and down when the keyboard appears and disappears accordingly
        if notification.name == Notification.Name.UIKeyboardWillShow ||
            notification.name == Notification.Name.UIKeyboardWillChangeFrame {
            // ... shifting up
            view.frame.origin.y = -keyboardRect.height + tabBarHeight
        } else {
            // ... shifting down to normal
            view.frame.origin.y = 0
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
    //  SearchBarDelegate protocol
    //
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // hiding the keyboard
        dismissKeyboard()
        
        
        presenter?.searchWith(searchString: searchBar.text!)
        
    }
    
    
    //
    // LOGIC
    //
    
    /// Dismisses the soft keyboard
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
