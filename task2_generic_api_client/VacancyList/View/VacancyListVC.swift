//
//  VacancyListVC.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 27.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import UIKit


class VacancyListVC: BaseSceenView, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,  VacancyListViewProtocol {
    
    //
    //  Observer
    //
    override func update() {
        if let unWrappedArray = presenter?.vacancyArray {
            self.vacancyArray = unWrappedArray
        }
    }
    
    //
    //  VacancyListViewProtocol
    //
    
    ///
    func showVacancyDetailFor(vacancy: Vacancy) {
        // TODO: segue to detail view
        print("\(#function): TBD")
    }
    
    func updateCellWith(_ result: ImageResult, forRowAt index: IndexPath, and vacancy: Vacancy) {
        
        guard let logoIndex = vacancyArray.index(of: vacancy),
            case let .success(image) = result else {
                if let empty_logo_cell = tableView.cellForRow(at: index) as? VacancyCell {
                    empty_logo_cell.updateNoLogo()
                }
                return
        }
        let logoIndexPath = IndexPath(item: logoIndex, section: 0)
        
        // When the request finishes, only update the cell if it's still visible
        if let cell = tableView.cellForRow(at: logoIndexPath) as? VacancyCell {
            cell.update(with: image)
        }
    }
    
    
    /// Controls the business indicator's state (on/off)
    func businessIndicator(Turn state: IndicatorStates) {
        switch state {
        case .On:
            // showing and animating
            spinner.isHidden = false
            spinner.startAnimating()
            break
        case .Off:
            // hiding and stopping
            spinner.isHidden = true
            spinner.stopAnimating()
            break
        }
    }
    
    /// represents a search request string
    var searchText: String {
        get {
            return searchBar.text!
        }
    }
    
    //
    //  Concrete VC
    //
    
    // Controls the view
    var presenter: VacancyListPresenter?
    
    //
    //  OUTLETS
    //
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    //
    // Field & Properties
    //
    
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
        //
        //  Spinner
        //
        spinner.isHidden = true
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 70
        
        // listening for keyboard events
        // to know when it appear in the screen and goes away
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showVacancyDetailFromList":
            if let row = tableView.indexPathForSelectedRow?.row {
                let vacancy = vacancyArray[row]
                let detailVacancyVC = segue.destination as! DetailVacancyVC
                detailVacancyVC.vacancy = vacancy
            }
        default:
            print("No such a segue: \(String(describing: segue.identifier))")
        }
    }
    
    //
    //  UITableViewDelegate
    //
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let vacancy = vacancyArray[indexPath.row]
        let imageUrl = vacancy.employer.logoUrl
        
        // DOWNLOADING DATA
        DispatchQueue.global(qos: .userInteractive).async {
            self.presenter?.needImageForUrl(imageUrl!, forRowAt: indexPath, and: vacancy)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
    //
    //  LOGIC
    //
    
    
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
