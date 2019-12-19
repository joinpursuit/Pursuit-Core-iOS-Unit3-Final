//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

//* Build a table view that loads and displays a list of the Elements, one per cell/row. Use a custom UITableViewCell subclass.  It should have 2 labels and one image.  The image should be pinned to the left of cell from the small images endpoint below.  The labels should be configured as below:
//
//    ```
//    Name
//    Symbol(Number) Atomic Weight
//
//    e.g.
//
//    Sodium
//    Na(11) 22.989769282
//    ```
//

//Load a thumbnail image on each row as described below under Endpoints > Images.  For full credit, use a custom tableViewCell to make the image more readable.
//
 var podcasts = [Podcast](){
        didSet{
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadPodcast(searchTerm: "swift")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else{
            fatalError("can't segue")
        }
        detailVC.podcast = podcasts[indexPath.row]
        
    }
    
    private func loadPodcast(searchTerm: String){
        PodcastAPICLient.fetchPodcast(query: searchTerm) {[weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async{
                    self?.showAlert(title: "Unable to load Podcasts", message: "\(appError)")}
            case .success(let dataArray):
                self?.podcasts = dataArray
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodCastCell else{
            fatalError("could not access PodCastCell")
        }
        let podcast = podcasts[indexPath.row]
        cell.configureCell(podcast: podcast)
        return cell
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else{
            DispatchQueue.main.async {
            self.showAlert(title: "Error", message: "Please type in a search term")
            
        }
            return
        }
        loadPodcast(searchTerm: searchQuery)
        
    }
    
    
}


