//
//  MovieDetailViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/27/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

// TODO: - create a view model for this
class MovieDetailViewController: UIViewController {
  
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!

  // MARK: - Properties
  var movie: Movie?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let movie = movie {
      self.title = movie.title
      releaseDateLabel.text = "Release Date: \(movie.releaseDate)"
      descriptionLabel.text = movie.overview
      
      if movie.imageState == .downloaded {
        movieImageView.image = movie.image
      } else {
        movieImageView.image = UIImage(named: "image-placeholder")
      }
    }
  }
    
}
