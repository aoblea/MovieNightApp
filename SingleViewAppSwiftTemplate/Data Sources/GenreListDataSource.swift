//
//  GenreListDataSource.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/27/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class GenreListDataSource: NSObject, UITableViewDataSource {
  
  private var genres = [Genre]()
  
  override init() {
    super.init()
  }
  
  // MARK: - Table view data source methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return genres.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
    let genre = object(at: indexPath)
    cell.textLabel?.text = genre.name

    return cell
  }
  
  // MARK: - Helper methods
  func object(at indexPath: IndexPath) -> Genre {
    return genres[indexPath.row]
  }
  
  func update(with data: [Genre]) {
    self.genres = data
  }
}
