//
//  ResultsListViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/26/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class ResultsListViewController: UITableViewController {
  
  // MARK: - Properties
  var movies: [Movie] = []
  let dataSource = ResultListDataSource()
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Results"
    
    setupTableView()
  }

  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = dataSource
  }
  
  // MARK: - Table view delegate methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showMovieDetails", sender: self)
  }
}

// MARK: - Navigation
extension ResultsListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMovieDetails" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let movie = dataSource.object(at: indexPath)
        let detailViewController = segue.destination as? MovieDetailViewController
        guard let detailVC = detailViewController else { return }
          detailVC.movie = movie
      }
    }
  }
}
