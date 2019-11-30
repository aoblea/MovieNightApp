//
//  ResultListDataSource.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/28/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class ResultListDataSource: NSObject, UITableViewDataSource {
  
  private var movies: [Movie]
  let pendingOperations = PendingOperations()
  let tableView: UITableView
  
  init(movies: [Movie], tableView: UITableView) {
    self.movies = movies
    self.tableView = tableView
    super.init()
  }
  
  // MARK: - Table view data source methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
    let movie = object(at: indexPath)
    
    cell.textLabel?.text = movie.title
    
    if movie.imageState == .placeholder {
      downloadMoviePoster(movie, at: indexPath)
    }
    
    return cell
  }
  
  // MARK: - Helper methods
  func object(at indexPath: IndexPath) -> Movie {
    return movies[indexPath.row]
  }
  
  func update(with data: [Movie]) {
    self.movies = data
  }
  
  func downloadMoviePoster(_ movie: Movie, at indexPath: IndexPath) {
    if let _ = pendingOperations.downloadsInProgress[indexPath] { return }
    
    let downloader = MovieDetailsOperation(movie: movie)
    
    downloader.completionBlock = {
      if downloader.isCancelled { return }
    
      DispatchQueue.main.async {
        self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
      }
    }
    pendingOperations.downloadsInProgress[indexPath] = downloader
    pendingOperations.downloadQueue.addOperation(downloader)
  }
  
}
