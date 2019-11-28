//
//  ResultListDataSource.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/28/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class ResultListDataSource: NSObject, UITableViewDataSource {
  
  private var data = [Movie]()
  
  override init() {
    super.init()
  }
  
  // MARK: - Table view data source methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
    let movie = object(at: indexPath)
    cell.textLabel?.text = movie.title
    
    return cell
  }
  
  // MARK: - Helper methods
  func object(at indexPath: IndexPath) -> Movie {
    return data[indexPath.row]
  }
  
  func update(with data: [Movie]) {
    self.data = data
  }
}
