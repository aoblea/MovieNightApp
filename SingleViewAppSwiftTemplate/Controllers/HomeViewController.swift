//
//  HomeViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/19/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

extension UIColor {
  struct AppColor {
    static var lightRed: UIColor = { return UIColor(red: 191/255, green: 88/255, blue: 88/255, alpha: 1.0) }()
  }
}

class HomeViewController: UIViewController {
  
  // MARK: - Properties
  
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()

    self.title = "Movie Night App"
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.barTintColor = UIColor.AppColor.lightRed

    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
    navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.white
    
    let client = MovieNightClient()
    /*
    // get genres
    client.genreList { (result) in
      switch result {
      case .success(let list):
        print(list.genres.compactMap { $0.name }) // list of genre names
        print(list.genres.compactMap { $0.id }) // list of genre id
      case .failure(let error):
        print(error)
      }
    }
    
    // get certifications
    client.certificationList { (result) in
      switch result {
      case .success(let result):
        // US List
        let list = result.certifications["US"]?.compactMap { $0.certification }
        
        if let list = list {
          print(list)
        } else {
          print("empty")
        }
        
        // meaning
        print(result.certifications["US"]!.compactMap { $0.meaning })
        
        // order
        print(result.certifications["US"]!.compactMap { $0.order })
        
      case .failure(let error):
        print(error)
      }
    }
    */
    
//    // get people
//    client.people { (result) in
//      switch result {
//      case .success(let people):
//        print(people.results.compactMap { $0.name })
//        print(people.results.compactMap { $0.id })
//      case .failure(let error):
//        print(error)
//      }
//    }
  
  }
  
  @objc func clear() {
    // Reset everything
  }
  
  // MARK: - Button Actions
  @IBAction func firstUser(_ sender: Any) {
    // when clicked, user starts choosing
  }
  
  @IBAction func secondUser(_ sender: Any) {
    
  }
  
  @IBAction func viewResults(_ sender: Any) {
    // When both users are ready, viewResults shows the results
    
  }
  
}
