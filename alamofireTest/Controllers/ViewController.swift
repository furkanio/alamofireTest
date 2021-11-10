//
//  ViewController.swift
//  spaceXtesting
//
//  Created by Furkan Yıldız on 20.06.2021.
//

import UIKit
//import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UISearchResultsUpdating, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchController.isActive){
            return filteredLaunches.count
        }
        return self.launches.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           if let cell = tableLaunches.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for:indexPath) as? PhotosTableViewCell{
               
            if (searchController.isActive){
                cell.launch = self.filteredLaunches[indexPath.row]
            }else {
                cell.launch = self.launches[indexPath.row]
            }
            
            return cell

           }
           
           return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue"){
            
            let indexPath = self.tableLaunches.indexPathForSelectedRow
            
            let tableViewDetail = segue.destination as? TableViewDetails
            
            let selectedLaunch: Model!
            
            if(searchController.isActive){
                selectedLaunch = filteredLaunches[indexPath!.row]
            }else {
                selectedLaunch = launches[indexPath!.row]
            }
            
            
            tableViewDetail?.selectedLaunch = selectedLaunch
            
            self.tableLaunches.deselectRow(at: indexPath!, animated: true)
            
            
        }
    }
    

    @IBOutlet weak var tableLaunches: UITableView!
    
    var launches = [Model]()
    var filteredLaunches = [Model]()
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "spaceX Launches"
        initSearchController()
        
        self.tableLaunches.delegate = self
        self.tableLaunches.dataSource = self
        
        self.tableLaunches.rowHeight = UITableView.automaticDimension
        self.tableLaunches.estimatedRowHeight = 44
        
        //register Cell .xib
        self.tableLaunches.register(UINib(nibName: "PhotosTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotosTableViewCell")
        
        
        let service = Service(baseUrl: "https://api.spacexdata.com/v2/")
        
        service.getAllLaunches(endPoint: "launches")
        
        service.completionHandle { [weak self] (launches, status, message) in
            if status {
                
                guard let self = self else {return}
                guard let _launches = launches else {return}
                self.launches = _launches
                self.tableLaunches.reloadData()
            }
        }
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All","2016","2017","2018", "2019", "2020" ]
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
}
    
    func filterForSearchTextAndScopeButton (searchText: String, scopeButton: String = "All") {
        
        filteredLaunches = launches.filter{
            
            model in
            let scopeMatch = (scopeButton == "All" || model.launch_year.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "")
            {
                let searchTextMatch = model.launch_year.lowercased().contains(searchText.lowercased())
                
                return scopeMatch && searchTextMatch
            }else {
                return scopeMatch
            }
        }
        tableLaunches.reloadData()
    }

    

}
