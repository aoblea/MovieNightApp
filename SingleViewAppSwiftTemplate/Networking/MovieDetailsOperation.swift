//
//  MovieDetailsOperation.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/29/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsOperation: Operation {
  let movie: Movie
  let client = MovieNightClient()
  
  init(movie: Movie) {
    self.movie = movie
    super.init()
  }
  
  override var isAsynchronous: Bool {
    return true
  }
  
  private var _finished = false
  override private(set) var isFinished: Bool {
    get {
      return _finished
    }
    
    set {
      willChangeValue(forKey: "isFinished")
      _finished = newValue
      didChangeValue(forKey: "isFinished")
    }
  }
  
  private var _executing = false
  override private(set) var isExecuting: Bool {
    get {
      return _executing
    }
    set {
      willChangeValue(forKey: "isExecuting")
      _executing = newValue
      didChangeValue(forKey: "isExecuting")
    }
  }
  
  override func start() {
    if isCancelled {
      isFinished = true
      return
    }
    
    isExecuting = true
    
    client.getImage(with: movie) { [unowned self] (result) in
      switch result {
      case .success(let image):
//        print("\(image) is downloaded")
        self.movie.imageState = .downloaded
        self.movie.image = UIImage(data: image)
        
        self.isExecuting = false
        self.isFinished = true
      case .failure(let error):
        print(error)
        self.movie.imageState = .failed
        self.isExecuting = false
        self.isFinished = true
      }
    }
  }
  
}
